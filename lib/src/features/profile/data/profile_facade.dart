import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/auth/auth.dart' show UserDtoX;
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/shared/shared.dart';

class ProfileFacade implements IProfileFacade {
  const ProfileFacade({
    required ProfileRemoteDatasource remote,
    required ProfileLocalDatasource local,
  }) : _remote = remote,
       _local = local;

  final ProfileRemoteDatasource _remote;
  final ProfileLocalDatasource _local;

  @override
  Future<Either<ProfileException, Profile>> editProfile({
    required ID id,
    SingleLineString? fullName,
    MultiLineString? bio,
    ImageFile? image,
  }) async {
    try {
      final response = await _remote.editProfile(
        id: id.getOrCrash(),
        fullName: fullName?.getOrCrash(),
        bio: bio?.getOrCrash(),
        image: image?.getOrCrash(),
      );

      final user = response.data!.toDomain;
      final updatedProfile = Profile.fromUserEntity(user);

      await _local.saveProfile(updatedProfile.toDto);

      return right(updatedProfile);
    } on DioException catch (error) {
      final exception = _handleDioException(error);
      return left(exception);
    } on TimeoutException {
      return left(const ProfileTimeoutException());
    }
  }

  @override
  Future<Either<ProfileException, Profile>> getProfile(ID id) async {
    try {
      final response = await _remote.getProfile(id.getOrCrash());
      return right(response.data!.toDomain);
    } on DioException catch (error) {
      final exception = _handleDioException(error);
      return left(exception);
    } on TimeoutException {
      return left(const ProfileTimeoutException());
    }
  }

  @override
  Future<Either<ProfileException, PaginatedList<Profile?>>> getProfiles({
    String include = 'subscribed',
    String? keywords,
    String sortBy = 'fullName',
    OrderBy orderBy = OrderBy.ASC,
    int page = 1,
    int size = kPageSize,
  }) async {
    try {
      final response = await _remote.getProfiles(
        include: include,
        keywords: keywords,
        sortBy: sortBy,
        orderBy: orderBy,
        page: page,
        size: size,
      );
      final data = response.data!;
      final paginatedList = PaginatedList(
        items: data.items.map((dto) => dto?.toDomain).toList(),
        currentPage: data.currentPage,
        totalItems: data.totalItems,
        totalPages: data.totalPages,
      );
      return right(paginatedList);
    } on DioException catch (error) {
      final exception = _handleDioException(error);
      return left(exception);
    } on TimeoutException {
      return left(const ProfileTimeoutException());
    }
  }

  @override
  Future<Either<ProfileException, PaginatedList<Profile?>>> getSubscribers({
    required ID subscriptionId,
    String include = 'subscribed',
    String? keywords,
    int page = 1,
    int size = kPageSize,
  }) async {
    try {
      final response = await _remote.subcribers(
        subscriptionId: subscriptionId.getOrCrash(),
        include: include,
        keywords: keywords,
        page: page,
        size: size,
      );
      final data = response.data!;
      final paginatedList = PaginatedList(
        items: data.items.map((dto) => dto?.toDomain).toList(),
        currentPage: data.currentPage,
        totalItems: data.totalItems,
        totalPages: data.totalPages,
      );
      return right(paginatedList);
    } on DioException catch (error) {
      final exception = _handleDioException(error);
      return left(exception);
    } on TimeoutException {
      return left(const ProfileTimeoutException());
    }
  }

  @override
  Future<Either<ProfileException, PaginatedList<Profile?>>> getSubscriptionss({
    required ID subscriberId,
    String include = 'subscribed',
    String? keywords,
    int page = 1,
    int size = kPageSize,
  }) async {
    try {
      final response = await _remote.subcribers(
        subscriberId: subscriberId.getOrCrash(),
        include: include,
        keywords: keywords,
        page: page,
        size: size,
      );
      final data = response.data!;
      final paginatedList = PaginatedList(
        items: data.items.map((dto) => dto?.toDomain).toList(),
        currentPage: data.currentPage,
        totalItems: data.totalItems,
        totalPages: data.totalPages,
      );
      return right(paginatedList);
    } on DioException catch (error) {
      final exception = _handleDioException(error);
      return left(exception);
    } on TimeoutException {
      return left(const ProfileTimeoutException());
    }
  }

  @override
  Future<Either<ProfileException, Unit>> subscribe(ID id) async {
    try {
      await _remote.subscribe(id.getOrCrash());
      return right(unit);
    } on DioException catch (error) {
      final exception = _handleDioException(error);
      return left(exception);
    } on TimeoutException {
      return left(const ProfileTimeoutException());
    }
  }

  @override
  Future<Either<ProfileException, Unit>> unsubscribe(ID id) async {
    try {
      await _remote.subscribe(id.getOrCrash());
      return right(unit);
    } on DioException catch (error) {
      final exception = _handleDioException(error);
      return left(exception);
    } on TimeoutException {
      return left(const ProfileTimeoutException());
    }
  }

  ProfileException _handleDioException(DioException error) {
    final errorData = error.response?.data;

    if (errorData == null) return const ProfileUnknownException();

    final baseError = errorData as Map<String, dynamic>;
    final base = BaseResponse.fromJson(baseError, (_) => null);

    return switch (base.error) {
      final Map<String, dynamic> errors => ProfileValidationException(errors),
      _ => ProfileExceptionWithMessage(base.message ?? 'Unknown error'),
    };
  }
}
