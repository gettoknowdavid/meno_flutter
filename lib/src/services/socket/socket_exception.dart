//
// ignore_for_file: inference_failure_on_function_return_type

class SocketException implements Exception {
  const SocketException(this.message);
  final dynamic message;
}

final class SocketValidationException extends SocketException {
  SocketValidationException(this.errors) : super(_validationErrors(errors));
  final Map<String, dynamic> errors;
}

String _validationErrors(Map<String, dynamic> errors) {
  return errors.values.map((e) => e.toString()).join('\n');
}

final class SocketTimeoutException extends SocketException {
  const SocketTimeoutException([super.message = 'Event timed out']);
}


// extension SocketExceptionX on SocketException {
//   String get message {
//     SocketException _getSocketError(dynamic error) {
//   final result = switch (error) {
//     final Map<String, dynamic> errors => SocketValidationException(errors),
//     _ => SocketException(error),
//   };
//   return result;
// }

//   }
// }
