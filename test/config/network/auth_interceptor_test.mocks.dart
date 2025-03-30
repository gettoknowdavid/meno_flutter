// Mocks generated by Mockito 5.4.5 from annotations
// in meno_flutter/test/config/network/auth_interceptor_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:dio/dio.dart' as _i4;
import 'package:meno_flutter/config/config.dart' as _i2;
import 'package:meno_flutter/services/services.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [AuthInterceptor].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthInterceptor extends _i1.Mock implements _i2.AuthInterceptor {
  @override
  _i3.Future<dynamic> onError(
    _i4.DioException? err,
    _i4.ErrorInterceptorHandler? handler,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#onError, [err, handler]),
            returnValue: _i3.Future<dynamic>.value(),
            returnValueForMissingStub: _i3.Future<dynamic>.value(),
          )
          as _i3.Future<dynamic>);

  @override
  _i3.Future<void> onRequest(
    _i4.RequestOptions? options,
    _i4.RequestInterceptorHandler? handler,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#onRequest, [options, handler]),
            returnValue: _i3.Future<void>.value(),
            returnValueForMissingStub: _i3.Future<void>.value(),
          )
          as _i3.Future<void>);

  @override
  void onResponse(
    _i4.Response<dynamic>? response,
    _i4.ResponseInterceptorHandler? handler,
  ) => super.noSuchMethod(
    Invocation.method(#onResponse, [response, handler]),
    returnValueForMissingStub: null,
  );
}

/// A class which mocks [SecureStorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSecureStorageService extends _i1.Mock
    implements _i5.SecureStorageService {
  @override
  _i3.Future<void> delete(String? key) =>
      (super.noSuchMethod(
            Invocation.method(#delete, [key]),
            returnValue: _i3.Future<void>.value(),
            returnValueForMissingStub: _i3.Future<void>.value(),
          )
          as _i3.Future<void>);

  @override
  _i3.Future<void> deleteAll() =>
      (super.noSuchMethod(
            Invocation.method(#deleteAll, []),
            returnValue: _i3.Future<void>.value(),
            returnValueForMissingStub: _i3.Future<void>.value(),
          )
          as _i3.Future<void>);

  @override
  _i3.Future<bool> hasKey(String? key) =>
      (super.noSuchMethod(
            Invocation.method(#hasKey, [key]),
            returnValue: _i3.Future<bool>.value(false),
            returnValueForMissingStub: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<String?> read(String? key) =>
      (super.noSuchMethod(
            Invocation.method(#read, [key]),
            returnValue: _i3.Future<String?>.value(),
            returnValueForMissingStub: _i3.Future<String?>.value(),
          )
          as _i3.Future<String?>);

  @override
  _i3.Future<void> write(String? key, {required String? value}) =>
      (super.noSuchMethod(
            Invocation.method(#write, [key], {#value: value}),
            returnValue: _i3.Future<void>.value(),
            returnValueForMissingStub: _i3.Future<void>.value(),
          )
          as _i3.Future<void>);
}
