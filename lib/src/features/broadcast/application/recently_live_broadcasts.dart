import 'package:meno_flutter/src/config/config.dart' show OrderBy;
import 'package:meno_flutter/src/features/broadcast/application/application.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart'
    show Broadcast;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recently_live_broadcasts.g.dart';

@riverpod
class RecentlyLiveBroadcasts extends _$RecentlyLiveBroadcasts {
  @override
  FutureOr<List<Broadcast?>> build() async {
    final facade = ref.read(broadcastFacadeProvider);

    final broadcasts = await facade.getBroadcasts(
      sortBy: 'endTime',
      orderBy: OrderBy.DESC,
      include: 'totalListeners',
      endTimeExist: true,
    );

    return broadcasts.fold(
      (exception) => throw exception,
      (success) => success.items,
    );
  }
}
