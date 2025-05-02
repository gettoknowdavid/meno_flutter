import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ended_broadcast_event.g.dart';

@Riverpod(keepAlive: true)
Stream<EndedBroadcastData> endedBroadcast(Ref ref) {
  final controller = StreamController<EndedBroadcastData>.broadcast();

  final socket = ref.read(socketProvider.notifier);

  void handleEndedBroadcast(dynamic data) {
    log('Received raw endedBroadcast event data: $data');

    try {
      final decoded = jsonDecode(jsonEncode(data)) as Map<String, dynamic>;
      final parsedData = EndedBroadcastData.fromJson(decoded);
      controller.add(parsedData);
      log('Successfully parsed and added EndedBroadcastData to stream.');
    } on Exception catch (error) {
      log('Error parsing endedBroadcast data: $error');
      controller.addError(
        SocketException('Failed to get endedBroadcast event data: $error'),
        StackTrace.current,
      );
    }
  }

  socket.addListener('endedBroadcast', handleEndedBroadcast);
  log('Listener added for "endedBroadcast" event.');

  ref.onDispose(() {
    log('Disposing & Removing listener and closing stream.');
    socket.removeListener('endedBroadcast', handleEndedBroadcast);
    controller.close();
  });

  return controller.stream;
}

@JsonSerializable()
class EndedBroadcastData with EquatableMixin {
  const EndedBroadcastData({
    required this.broadcastDetails,
    required this.reason,
  });

  factory EndedBroadcastData.fromJson(Map<String, dynamic> json) =>
      _$EndedBroadcastDataFromJson(json);

  Map<String, dynamic> toJson() => _$EndedBroadcastDataToJson(this);

  final BroadcastDto broadcastDetails;
  final EndedBroadcastReason reason;

  @override
  List<Object?> get props => [broadcastDetails, reason];
}

@JsonSerializable()
class EndedBroadcastReason with EquatableMixin {
  const EndedBroadcastReason({required this.type, required this.message});

  factory EndedBroadcastReason.fromJson(Map<String, dynamic> json) =>
      _$EndedBroadcastReasonFromJson(json);

  Map<String, dynamic> toJson() => _$EndedBroadcastReasonToJson(this);

  final String type;
  final String message;

  @override
  List<Object?> get props => [type, message];
}
