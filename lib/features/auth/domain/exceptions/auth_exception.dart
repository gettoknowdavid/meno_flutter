import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meno_flutter/exceptions/meno_exception.dart';

part 'auth_exception.freezed.dart';

@freezed
class AuthException with _$AuthException implements MenoException {
  const factory AuthException.message(String msg) = AuthExceptionWithMessage;
  const factory AuthException.invalidEmailOrPassword() =
      InvalidEmailOrPasswordException;
  const factory AuthException.unableToVerifyEmail() =
      UnableToVerifyEmailException;
  const factory AuthException.emailAlreadyInUse() = EmailAlreadyInUseException;
  const factory AuthException.tokenExpired() = AuthTokenExpiredException;
  const factory AuthException.unknown() = UnknownAuthException;
  const factory AuthException.server() = AuthServerException;
  const factory AuthException.validation(Map<String, dynamic> errors) =
      AuthValidationException;
}

extension AuthExceptionX on AuthException {
  String get message {
    return switch (this) {
      AuthExceptionWithMessage(:final msg) => msg,
      InvalidEmailOrPasswordException() => 'Invalid email of password.',
      UnableToVerifyEmailException() =>
        'Unable to verify your email at this time. Try again later.',
      EmailAlreadyInUseException() =>
        'Email already in use by another account. Try logging in.',
      AuthTokenExpiredException() =>
        'Your authentication token has expired. Please log in again.',
      AuthValidationException(:final errors) => _formatValidationErrors(errors),
      _ => 'Unknown exception',
    };
  }

  /// Helper function to format validation errors nicely
  String _formatValidationErrors(Map<String, dynamic> errors) {
    return errors.entries.map((e) => '${e.key}: ${e.value}').join('\n');
  }
}
