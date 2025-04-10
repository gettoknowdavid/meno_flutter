import 'package:equatable/equatable.dart';

sealed class BroadcastException with EquatableMixin implements Exception {
  const BroadcastException(this.message);
  final String message;
}

final class BroadcastServerException extends BroadcastException {
  const BroadcastServerException([super.message = 'Server exception']);

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}

final class BroadcastNetworkException extends BroadcastException {
  const BroadcastNetworkException([super.message = 'Network exception']);

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}

final class BroadcastExceptionWithMessage extends BroadcastException {
  const BroadcastExceptionWithMessage(super.message);

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}
