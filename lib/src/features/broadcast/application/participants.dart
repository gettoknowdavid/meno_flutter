import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'participants.g.dart';

@Riverpod(keepAlive: true)
class Participants extends _$Participants {
  Socket get _socket => ref.read(socketProvider.notifier);

  /// Priority bucket for [ParticipantRole.host].
  /// This is not a list as there will be only one host broadcast
  Participant? _host;

  /// Priority bucket for [ParticipantRole.cohost]
  final LinkedHashSet<Participant> _cohosts = LinkedHashSet();

  /// Priority bucket for [ParticipantRole.listener]
  final LinkedHashSet<Participant> _listeners = LinkedHashSet();

  /// Tracks the initialization state of the Streams
  bool _listenersInitialized = false;

  @override
  FutureOr<List<Participant?>> build() async {
    final id = ref.read(broadcastIDProvider);
    if (id == null) return [];

    state = const AsyncLoading();

    log('LiveParticipantsNotifier initializing for $id...');

    // Setup listeners for socket events
    _setupSocketListeners();

    // Cleanup listeners on dispose
    ref.onDispose(() {
      log('Disposing LiveParticipantsNotifier for $id...');
      _removeSocketListeners();
      // Clear internal buckets on dispose
      _host = null;
      _cohosts.clear();
      _listeners.clear();
    });

    final facade = ref.read(broadcastFacadeProvider);
    final response = await facade.liveParticipants(id);

    final participants = response.fold(
      (exception) => throw exception,
      _initialize,
    );

    _listenersInitialized = true;

    state = AsyncData(participants);
    return participants;
  }

  void _setupSocketListeners() {
    _socket.addListener('newBroadcastListener', _onParticipantJoined);
    _socket.addListener('broadcastListenerLeft', _onParticipantLeft);
    log('Socket listeners added for participant join/leave');
  }

  void _removeSocketListeners() {
    _socket.removeListener('newBroadcastListener', _onParticipantJoined);
    _socket.removeListener('broadcastListenerLeft', _onParticipantLeft);
    log('Socket listeners removed for participant join/leave');
  }

  List<Participant?> _initialize(List<Participant?> participants) {
    _initializeBuckets(participants);
    return _buildSortedList();
  }

  // What happens when a new listener or participant joins a live broadcast
  // Subscribes to the `newBroadcastListener` web socket event
  void _onParticipantJoined(dynamic data) {
    log('New Broadcast Participant Added => $data');
    try {
      final json = _ensureMap(data);
      final participant = ParticipantDto.fromJson(json).toDomain;

      state.whenData((_) {
        if (!_listenersInitialized) return;
        _addToBucket(participant);

        state = AsyncData(_buildSortedList());
        log('${participant.fullName.getOrCrash()} joined the broadcast.');
      });
    } on Exception catch (error) {
      log('Error adding new participant: $error');
    }
  }

  // What happens when a listener or participant leaves a live broadcast
  // Subscribes to the `broadcastListenerLeft` web socket event
  void _onParticipantLeft(dynamic data) {
    log('Broadcast Participant Left => $data');
    try {
      final json = _ensureMap(data);
      final participant = ParticipantDto.fromJson(json).toDomain;

      state.whenData((_) {
        if (!_listenersInitialized) return;
        _removeFromBucket(participant);

        state = AsyncData(_buildSortedList());
        log('${participant.fullName.getOrCrash()} left the broadcast.');
      });
    } on Exception catch (error) {
      log('Error adding new participant: $error');
    }
  }

  // --- Internal Helper Methods ---
  // (These remain the same as before, operating on _host, _cohosts, _listeners)
  Map<String, dynamic> _ensureMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    return jsonDecode(jsonEncode(data)) as Map<String, dynamic>;
  }

  void _addToBucket(Participant? participant) {
    if (participant == null) return;

    switch (participant.role) {
      case ParticipantRole.host || ParticipantRole.HOST:
        _host = participant;
        return;
      case ParticipantRole.cohost || ParticipantRole.COHOST:
        _cohosts.add(participant);
        return;
      case ParticipantRole.listener || ParticipantRole.LISTENER:
        _listeners.add(participant);
        return;
      case null:
        return;
    }
  }

  void _removeFromBucket(Participant? participant) {
    if (participant == null) return;

    switch (participant.role) {
      case ParticipantRole.host || ParticipantRole.HOST:
        if (_host?.id == participant.id) _host = null;
        return;
      case ParticipantRole.cohost || ParticipantRole.COHOST:
        _cohosts.remove(participant);
        return;
      case ParticipantRole.listener || ParticipantRole.LISTENER:
        _listeners.remove(participant);
        return;
      case null:
        return;
    }
  }

  void _initializeBuckets(List<Participant?> participants) {
    _host = null;
    _cohosts.clear();
    _listeners.clear();

    for (final participant in participants) {
      _addToBucket(participant);
    }

    log('Buckets initialized for ${ref.read(broadcastIDProvider)}.');
    log('Host: ${_host != null}');
    log('Cohosts: ${_cohosts.length}, Listeners: ${_listeners.length}');
  }

  List<Participant?> _buildSortedList() {
    return [if (_host != null) _host!, ..._cohosts, ..._listeners];
  }
}
