import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_remote_datasource.g.dart';

@RestApi()
abstract class ProfileRemoteDatasource {
  factory ProfileRemoteDatasource(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ProfileRemoteDatasource;

  @PUT('/api/v1/users/{userId}/profile')
  @MultiPart()
  @Extra({'requestType': RequestType.protected})
  Future<BaseResponse<UserDto>> editProfile({
    @Path('userId') required String id,
    @Part() String? fullName,
    @Part() String? bio,
    @Part(name: 'image', contentType: 'image/png') File? image,
  });

  @GET('/api/v1/users/{userId}/profile')
  @Extra({'requestType': RequestType.protected})
  Future<BaseResponse<ProfileDto>> getProfile(@Path('userId') String id);

  @GET('/api/v1/users/profiles')
  @Extra({'requestType': RequestType.protected})
  Future<BaseResponse<PaginatedProfileResponse<ProfileDto?>>> getProfiles({
    @Query('keywords') String? keywords,
    @Query('include') String? include,
    @Query('sortBy') String? sortBy,
    @Query('orderBy') OrderBy? orderBy,
    @Query('page') int? page,
    @Query('size') int? size,
  });

  @GET('/api/v1/subscribers')
  @Extra({'requestType': RequestType.protected})
  Future<BaseResponse<PaginatedProfileResponse<ProfileDto?>>> subcribers({
    @Query('subscriberId') String? subscriberId,
    @Query('subscriptionId') String? subscriptionId,
    @Query('keywords') String? keywords,
    @Query('include') String? include,
    @Query('page') int? page,
    @Query('size') int? size,
  });

  @POST('/api/v1/subscribers')
  @Extra({'requestType': RequestType.protected})
  Future<BaseResponse<dynamic>> subscribe(@Field('userId') String id);

  @DELETE('/api/v1/subscribers')
  @Extra({'requestType': RequestType.protected})
  Future<BaseResponse<dynamic>> unsubscribe(@Field('userId') String id);
}
