import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/config/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

/// The type of Dio Request sent to the backend server.
///
/// Helps to decide if the request should require a  bearer token or not
///
enum RequestType {
  /// Request requires a token
  protected,

  /// Request does not require a token
  unprotected,
}

@riverpod
Dio dio(Ref ref, String baseUrl) {
  final interceptor = ref.read(authInterceptorProvider);
  final dio = Dio()..options = BaseOptions(baseUrl: baseUrl);
  dio.interceptors.add(interceptor);
  return dio;
}
