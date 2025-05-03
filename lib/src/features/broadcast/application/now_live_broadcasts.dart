import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/services/socket/socket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'now_live_broadcasts.g.dart';

@Riverpod(keepAlive: true)
Stream<Broadcast> newBroadcastEvent(Ref ref) {
  final controller = StreamController<Broadcast>.broadcast();

  final socket = ref.read(socketProvider.notifier);

  void onNewBroadcast(dynamic data) {
    log('Received raw new broadcast event data: $data');

    try {
      final decoded = jsonDecode(jsonEncode(data)) as Map<String, dynamic>;
      final broadcast = BroadcastDto.fromJson(decoded).toDomain;
      controller.add(broadcast);
      log('Successfully parsed and added new Broadcast to stream.');
    } on Exception catch (error) {
      log('Error parsing newBroadcast data: $error');
      controller.addError(
        SocketException('Failed to get newBroadcast event data: $error'),
        StackTrace.current,
      );
    }
  }

  socket.addListener('newBroadcast', onNewBroadcast);
  log('Listener added for "newBroadcast" event.');

  ref.onDispose(() {
    log('Disposing & Removing listener and closing stream.');
    socket.removeListener('newBroadcast', onNewBroadcast);
    controller.close();
  });

  return controller.stream;
}

@Riverpod(keepAlive: true)
class NowLiveBroadcasts extends _$NowLiveBroadcasts {
  IBroadcastFacade get _facade => ref.read(broadcastFacadeProvider);

  @override
  FutureOr<List<Broadcast?>> build() async {
    ref.listen(newBroadcastEventProvider, (previous, next) {
      next.whenData((broadcast) {
        final currentBroadcasts = List<Broadcast?>.from(state.value ?? []);
        final updatedBroadcasts = [broadcast, ...currentBroadcasts];
        state = AsyncData(updatedBroadcasts);
      });
    });

    ref.listen(endedBroadcastEventProvider, (previous, next) {
      next.whenData((endedBroadcastData) {
        final broadcast = endedBroadcastData.broadcastDetails;
        final currentBroadcasts = List<Broadcast?>.from(state.value ?? []);
        final updatedBroadcasts =
            currentBroadcasts
                .where((b) => b?.id.getOrCrash() != broadcast.id)
                .toList();
        state = AsyncData(updatedBroadcasts);
      });
    });

    final response = await _facade.getBroadcasts(
      sortBy: 'startTime',
      orderBy: OrderBy.ASC,
      endTimeExist: false,
      startTimeExist: true,
      include: 'totalListeners',
      status: 'active',
    );

    return response.fold(
      (exception) => throw exception,
      (paginatedBroadcasts) => paginatedBroadcasts.items,
    );
  }
}
