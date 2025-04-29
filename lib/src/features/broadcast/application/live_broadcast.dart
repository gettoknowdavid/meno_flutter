import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_broadcast.g.dart';

final liveBroadcastIDProvider = StateProvider<ID?>((ref) => null);

@riverpod
FutureOr<Broadcast?> startBroadcast(Ref ref, ID id) async {
  final facade = ref.read(broadcastFacadeProvider);
  final result = await facade.startBroadcast(id);
  return result.fold((exception) => throw exception, (broadcast) => broadcast);
}

@Riverpod(keepAlive: true)
class LiveBroadcast extends _$LiveBroadcast {
  IBroadcastFacade get _facade => ref.read(broadcastFacadeProvider);

  @override
  FutureOr<Broadcast> build() async {
    final broadcastID = ref.watch(liveBroadcastIDProvider);
    if (broadcastID == null) throw const BroadcastNotFoundException();

    final result = await _facade.getBroadcasts(
      id: broadcastID,
      sortBy: 'title',
      orderBy: OrderBy.ASC,
      size: 1,
    );

    return result.fold((exception) => throw exception, (paginatedList) {
      final broadcast = paginatedList.items.first;
      if (broadcast == null) throw const BroadcastNotFoundException();
      return broadcast;
    });
  }

  void onBroadcastStarted(Broadcast broadcast) {
    state = AsyncData(broadcast);
  }
}
