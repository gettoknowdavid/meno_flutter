//
// ignore_for_file: inference_failure_on_function_return_type

class SocketException implements Exception {
  const SocketException(this.message);
  final dynamic message;
}
