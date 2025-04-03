import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/services/services.dart';
import 'package:mockito/annotations.dart';
import 'auth_interceptor_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthInterceptor>(),
  MockSpec<SecureStorageService>(),
])
void main() {
  // late MockSecureStorageService mockStorage;
  late MockAuthInterceptor mockAuthInterceptor;
  group('AuthInterceptor', () {

    setUp(() {
      // mockStorage = MockSecureStorageService();
      mockAuthInterceptor = MockAuthInterceptor();
    });

    group('_getToken', () {});

    test(
      'should not add Authourization header when request is unprotected',
      () async {
        const requestType = RequestType.unprotected;
        final options = RequestOptions(extra: {'requestType': requestType});
        final handler = RequestInterceptorHandler();
        await mockAuthInterceptor.onRequest(options, handler);
        expect(
          options.headers.containsKey(HttpHeaders.authorizationHeader),
          false,
        );
      },
    );
  });
}
