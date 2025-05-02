// import 'package:meno_flutter/src/config/config.dart' show BaseResponse;
// import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
// import 'package:meno_flutter/src/services/socket/socket.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'end_broadcast.g.dart';

// @riverpod
// class EndBroadcast extends _$EndBroadcast {
//   @override
//   Future<bool> build() async => false;

//   Future<void> end() async {
//     final id = ref.read(broadcastIDProvider);
//     if (id == null) throw const BroadcastNotFoundException();

//     state = const AsyncLoading();

//     final socket = ref.read(socketProvider.notifier);

//     final result = await socket.emitWithAck('endBroadcast', {
//       'broadcastId': id.getOrCrash(),
//     });

//     final response = BaseResponse.fromJson(
//       result as Map<String, dynamic>,
//       (json) => json as dynamic,
//     );

//     if (response.error == null) {
//       state = const AsyncData(true);
//     } else {
//       final message = _getSocketError(response.error).message as String;
//       final error = BroadcastExceptionWithMessage(message);
//       state = AsyncError(error, StackTrace.current);
//     }
//   }
// }

// SocketException _getSocketError(dynamic error) {
//   final result = switch (error) {
//     final Map<String, dynamic> errors => SocketValidationException(errors),
//     _ => SocketException(error),
//   };
//   return result;
// }
