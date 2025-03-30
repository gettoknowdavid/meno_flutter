import 'package:freezed_annotation/freezed_annotation.dart';

part 'meno_exception.freezed.dart';

@freezed
class MenoException with _$MenoException implements Exception {
  const factory MenoException.message(String msg) = MenoExceptionWithMessage;
  const factory MenoException.serverError() = MenoServerException;
  const factory MenoException.networkError() = MenoNetworkException;
  const factory MenoException.timeoutError() = MenoTimeoutException;
  const factory MenoException.unknownError() = MenoUnknownException;
}
