// import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'start_broadcast.g.dart';

// @riverpod
// class StartBroadcast extends _$StartBroadcast {
//   @override
//   FutureOr<Broadcast?> build() => null;

//   Future<void> start() async {
//     final id = ref.read(broadcastIDProvider);
//     if (id == null) throw const BroadcastNotFoundException();

//     state = const AsyncLoading();

//     final facade = ref.read(broadcastFacadeProvider);
//     final result = await facade.startBroadcast(id);

//     state = result.fold(
//       (exception) => AsyncError(exception, StackTrace.current),
//       AsyncData.new,
//     );
//   }
// }
