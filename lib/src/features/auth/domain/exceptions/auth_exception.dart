sealed class AuthException implements Exception {
  const AuthException(this.message);
  final String message;
}

final class AuthServerException extends AuthException {
  const AuthServerException([super.message = 'Server authentication error.']);
}

final class AuthUnknownException extends AuthException {
  const AuthUnknownException([super.message = 'Unknown authentication error.']);
}

final class NoCredentialsException extends AuthException {
  const NoCredentialsException([super.message = 'No credentials provided.']);
}

final class InvalidEmailOrPasswordException extends AuthException {
  const InvalidEmailOrPasswordException([
    super.message = 'Invalid email of password.',
  ]);
}

final class UnableToVerifyEmailException extends AuthException {
  const UnableToVerifyEmailException([
    super.message = 'Unable to verify your email at this time. Try again.',
  ]);
}

final class EmailAlreadyInUseException extends AuthException {
  const EmailAlreadyInUseException([
    super.message = 'Email already in use by another account. Try logging in.',
  ]);
}

final class TokenExpiredException extends AuthException {
  const TokenExpiredException([
    super.message = 'Authentication token has expired. Please log in again.',
  ]);
}

final class AuthValidationException extends AuthException {
  AuthValidationException(this.errors) : super(_formatValidationErrors(errors));
  final Map<String, dynamic> errors;
}

final class AuthExceptionWithMessage extends AuthException {
  const AuthExceptionWithMessage(super.message);
}

/// Helper function to format validation errors nicely
String _formatValidationErrors(Map<String, dynamic> errors) {
  return errors.entries.map((e) => '${e.key}: ${e.value}').join('\n');
}
