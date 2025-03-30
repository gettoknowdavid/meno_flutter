import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/config/env/env.dart';
import 'package:meno_flutter/config/network/network.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_datasource.g.dart';

@riverpod
AuthRemoteDatasource authRemote(Ref ref) {
  final baseUrl = ref.read(menoUrlProvider);
  final dio = ref.read(dioProvider(baseUrl));
  return AuthRemoteDatasource(dio, baseUrl: baseUrl);
}

@RestApi(callAdapter: AuthAdapter)
abstract class AuthRemoteDatasource {
  factory AuthRemoteDatasource(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _AuthRemoteDatasource;

  /// Signs in the user using their email address and password.
  ///
  /// Returns an [BaseResponse] object, which contains either a
  /// [UserCredentialDto] object or an `error` object.
  @POST('/api/v1/users/signin')
  @Extra({'requestType': RequestType.unprotected})
  Future<Either<AuthException, BaseResponse<UserCredentialDto>>> login({
    @Field() required String email,
    @Field() required String password,
  });

  /// Registers the user.
  ///
  /// Returns an [BaseResponse] object, which contains either a
  /// [UserCredentialDto] object or an `error` object.
  @POST('/api/v1/users/signup')
  @MultiPart()
  Future<Either<AuthException, BaseResponse<UserCredentialDto>>> register({
    @Part() required String fullName,
    @Part() required String email,
    @Part() required String password,
    @Part() String? bio,
  });
}

class AuthAdapter<T>
    extends
        CallAdapter<
          Future<BaseResponse<T>>,
          Future<Either<AuthException, BaseResponse<T>>>
        > {
  @override
  Future<Either<AuthException, BaseResponse<T>>> adapt(
    Future<BaseResponse<T>> Function() call,
  ) async {
    try {
      final response = await call();
      return right(response);
    } on DioException catch (e) {
      final exception = _handleException<T>(e);
      return left(exception);
    }
  }
}

AuthException _handleException<T>(DioException exception) {
  final errorData = exception.response?.data;

  if (errorData == null) return const UnknownAuthException();

  final base = BaseResponse.fromJson(
    errorData as Map<String, dynamic>,
    (_) => null,
  );

  return switch (base.error) {
    final Map<String, dynamic> errors => AuthValidationException(errors),
    _ => AuthExceptionWithMessage(base.message),
  };
}
