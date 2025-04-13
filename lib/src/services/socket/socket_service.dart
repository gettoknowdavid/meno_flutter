//
// ignore_for_file: inference_failure_on_function_return_type

import 'dart:async';
import 'dart:developer';

import 'package:meno_flutter/src/config/env/env.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/services/socket/socket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'socket_service.g.dart';

@Riverpod(keepAlive: true)
class Socket extends _$Socket {
  io.Socket? _socket;

  @override
  SocketState build() {
    state = const SocketState.disconnected();

    ref.listen(authStateChangesProvider, (_, next) {
      next.whenData((credential) {
        if (credential == null) {
          disconnect();
        } else {
          // Connect only if not already connected/connecting
          // This prevents redundant attempts if auth emits multiple
          // times quickly
          if (state is SocketDisconnected || state is SocketConnectFailure) {
            _connect(credential);
          }
        }
      });
    }, fireImmediately: true);

    ref.onDispose(disconnect);

    return state;
  }

  io.Socket? get socket => _socket;

  void _connect(UserCredential credential) {
    // Prevent multiple connection attempts if already connecting/connected
    if (state is SocketConnected || state is SocketConnectInProgress) {
      log('Socket already connected or connecting.');
      return;
    }

    log('Socket connecting...');
    state = const SocketConnectInProgress();

    final token = credential.token.getOrNull();

    if (token == null) {
      log('Socket could not retrieve token.');
      const exception = SocketException('No authentication token available');
      state = const SocketConnectFailure(exception);
      return;
    }

    log('Socket retrieved token successfully.');

    // Ensure previous socket is disposed if any (paranoid check)
    _socket?.dispose();

    try {
      log('Socket is creating...');
      final query = {'token': token};
      _socket = io.io(
        Env.menoApiUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery(query)
            .disableAutoConnect()
            .build(),
      );

      _setupCoreListeners();
      log('Socket core listeners setup.');

      _socket!.connect();
      log('Socket connection attempt initiated.');
    } on Exception catch (e) {
      log('Error creating or connecting socket: $e');
      final exception = SocketException(e.toString());
      state = SocketConnectFailure(exception);
      _socket = null;
    }
  }

  void disconnect() {
    if (_socket == null && state is SocketDisconnected) return;

    log('Socket disconnecting...');
    _socket?.dispose();
    _socket = null;

    // Only update state if not already disconnected to avoid redundant
    // notifications
    if (state is! SocketDisconnected) {
      state = const SocketDisconnected();
      log('Socket disconnected successfully.');
    }
  }

  void _setupCoreListeners() {
    _socket?.onConnect((_) {
      log('Socket Connected: ${_socket?.id}');
      state = const SocketConnected();
    });

    _socket?.onDisconnect((_) {
      log('Socket Disconnected');
      // Don't automatically set to error, could be intentional
      if (state is! SocketDisconnected) {
        // Avoid state loop if disconnect was called
        state = const SocketDisconnected();
      }
    });

    _socket?.onError((data) {
      log('Socket Error: $data');
      final exception = SocketException(data);
      state = SocketConnectFailure(exception);
    });

    _socket?.onConnectError((data) {
      log('Socket Connection Error: $data');
      final exception = SocketException(data);
      state = SocketConnectFailure(exception);
      _socket?.disconnect();
    });

    _socket?.onReconnectAttempt((attempt) {
      log('Socket Reconnecting attempt: $attempt');
      state = const SocketConnectInProgress();
    });

    _socket?.onReconnect((attempt) {
      log('Socket Reconnected after $attempt attempts');
      // State will be set to connected via the 'connect' event handler
    });

    _socket?.onReconnectFailed((_) {
      log('Socket Reconnection Failed');
      const exception = SocketException('Socket failed to reconnect');
      state = const SocketConnectFailure(exception);
    });

    _socket?.onReconnectError((data) {
      log('Socket Reconnection Error: $data');
      final exception = SocketException(data);
      state = SocketConnectFailure(exception);
    });
  }

  /// Emits an event with optional acknowledgment.
  /// Returns true if the event was emitted successfully, false otherwise.
  Future<bool> emitWithAck(
    String event,
    dynamic data, {
    Duration? timeout,
    Function(dynamic)? ack,
  }) async {
    if (state is! SocketConnected || _socket == null) {
      log('Emit failed: Socket not connected.');
      // Call ack with error if provided
      ack?.call({'error': 'Socket not connected'});
      return false;
    }

    final completer = Completer<bool>();
    Function ackWrapper;

    if (ack != null) {
      ackWrapper = (dynamic response) {
        ack(response);
        if (!completer.isCompleted) completer.complete(true);
      };
    } else {
      ackWrapper = () {
        // Still need an ack for completion signal if none provided by caller
        if (!completer.isCompleted) completer.complete(true);
      };
    }

    try {
      log('Emitting event: $event');
      _socket!.emitWithAck(event, data, ack: ackWrapper);

      // Handle timeout if specified
      if (timeout != null) {
        Future.delayed(timeout, () {
          if (!completer.isCompleted) {
            log('Emit ack timeout for event: $event');
            completer.complete(false);
          }
        });
      } else {
        // If no timeout and no ack expected from server, complete immediately
        // Note: This assumes emit itself is synchronous locally which it is.
        // However, if caller passes ack=null, it implies fire-and-forget,
        // so maybe completing immediately is fine. Let's stick with ackWrapper.
      }

      return completer.future;
    } on Exception catch (e) {
      log('Error emitting event $event: $e');
      if (!completer.isCompleted) completer.complete(false);
      return false;
    }
  }

  // Simpler fire-and-forget emit
  bool emit(String event, dynamic data) {
    if (state is! SocketConnected || _socket == null) {
      log('Emit (simple) failed: Socket not connected.');
      return false;
    }

    try {
      log('Emitting event (simple): $event');
      _socket!.emitWithAck(event, data);
      return true;
    } on Exception catch (e) {
      log('Error emitting event (simple) $event: $e');
      return false;
    }
  }

  // Method for feature providers to add their listeners
  void addListener(String event, Function(dynamic) handler) {
    if (_socket == null) {
      log('Warning: Socket not initialized, cannot add listener for $event');
      return;
    }
    _socket?.on(event, handler);
  }

  // Method for feature providers to remove their listeners
  void removeListener(String event, [Function(dynamic)? handler]) {
    if (_socket == null) {
      log('Warning: Socket not initialized, cannot remove listener for $event');
      return;
    }
    // Providing the specific handler is safer if multiple listeners exist
    // for the same event
    if (handler != null) {
      _socket!.off(event, handler);
    } else {
      _socket!.off(event);
    }
  }
}
