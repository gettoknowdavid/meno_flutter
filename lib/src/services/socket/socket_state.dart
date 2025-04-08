import 'package:meno_flutter/src/services/socket/socket_exception.dart';

sealed class SocketState {
  const SocketState();

  const factory SocketState.disconnected() = SocketDisconnected;
  const factory SocketState.connectInProgress() = SocketConnectInProgress;
  const factory SocketState.connected() = SocketConnected;
  const factory SocketState.connectFailure(SocketException exception) =
      SocketConnectFailure;
}

final class SocketDisconnected extends SocketState {
  const SocketDisconnected();
}

final class SocketConnectInProgress extends SocketState {
  const SocketConnectInProgress();
}

final class SocketConnected extends SocketState {
  const SocketConnected();
}

final class SocketConnectFailure extends SocketState {
  const SocketConnectFailure(this.exception);
  final SocketException exception;
}
