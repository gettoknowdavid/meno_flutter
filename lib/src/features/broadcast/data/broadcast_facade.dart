import 'dart:async' show TimeoutException;

import 'package:dartz/dartz.dart' show Either, Left, Right, Unit, unit;
import 'package:dio/dio.dart' show CancelToken, DioException;
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/shared/shared.dart';

class BroadcastFacade implements IBroadcastFacade {
  const BroadcastFacade({required BroadcastRemoteDatasource remote})
    : _remote = remote;

  final BroadcastRemoteDatasource _remote;

  @override
  Future<Either<BroadcastException, Broadcast>> createBroadcast({
    required SingleLineString title,
    required MultiLineString description,
    ImageFile? image,
    String? timezone,
    List<ID>? cohosts,
  }) async {
    try {
      final response = await _remote.createBroadcast(
        title: title.getOrCrash(),
        description: description.getOrCrash(),
        image: image?.getOrNull(),
        cohosts: cohosts?.map((cohost) => cohost.getOrCrash()).toList(),
        timezone: timezone,
      );
      return Right(response.data!.toDomain);
    } on DioException catch (e) {
      final error = _handleDioException(e);
      return Left(error);
    } on TimeoutException {
      return const Left(BroadcastTimeoutException());
    }
  }

  @override
  Future<Either<BroadcastException, Unit>> deleteBroadcast(ID id) async {
    try {
      await _remote.deleteBroadcast(id: id.getOrCrash());
      return const Right(unit);
    } on DioException catch (e) {
      final error = _handleDioException(e);
      return Left(error);
    } on TimeoutException {
      return const Left(BroadcastTimeoutException());
    }
  }

  @override
  Future<Either<BroadcastException, Broadcast>> editBroadcast({
    required ID id,
    SingleLineString? title,
    MultiLineString? description,
    ImageFile? image,
    String? timezone,
    DateTime? startTime,
  }) async {
    try {
      final response = await _remote.editBroadcast(
        id: id.getOrCrash(),
        title: title?.getOrNull(),
        description: description?.getOrNull(),
        image: image?.getOrNull(),
        timeZone: timezone,
        startTime: startTime.toString(),
      );
      return Right(response.data!.toDomain);
    } on DioException catch (e) {
      final error = _handleDioException(e);
      return Left(error);
    } on TimeoutException {
      return const Left(BroadcastTimeoutException());
    }
  }

  @override
  Future<Either<BroadcastException, PaginatedList<Broadcast?>>> getBroadcasts({
    required String sortBy,
    required OrderBy orderBy,
    ID? id,
    String? status,
    String? include,
    bool? onlySubscriptions,
    String? keywords,
    ID? creatorId,
    int page = 1,
    int size = 8,
    String? endTimeGT,
    String? endTimeLT,
    bool? endTimeExist,
    String? startTimeGT,
    String? startTimeLT,
    bool? startTimeExist,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _remote.getBroadcasts(
        status: status,
        include: include,
        id: id?.getOrNull(),
        onlySubscriptions: onlySubscriptions,
        keywords: keywords,
        creatorId: creatorId?.getOrNull(),
        sortBy: sortBy,
        orderBy: orderBy.name,
        page: page,
        size: size,
        endTimeGT: endTimeGT,
        endTimeLT: endTimeLT,
        endTimeExist: endTimeExist,
        startTimeGT: startTimeGT,
        startTimeLT: startTimeLT,
        startTimeExist: startTimeExist,
      );
      final data = response.data!;
      final paginatedList = PaginatedList(
        items: data.broadcasts.map((dto) => dto?.toDomain).toList(),
        currentPage: data.currentPage,
        totalItems: data.totalItems,
        totalPages: data.totalPages,
      );
      return Right(paginatedList);
    } on DioException catch (e) {
      final error = _handleDioException(e);
      return Left(error);
    } on TimeoutException {
      return const Left(BroadcastTimeoutException());
    }
  }

  @override
  Future<Either<BroadcastException, Broadcast>> joinBroadcast(ID id) async {
    try {
      final response = await _remote.joinBroadcast(id: id.getOrCrash());
      final data = response.data!;
      final broadcastWithoutToken = data.broadcast.toDomain;
      final broadcastWithToken = broadcastWithoutToken.copyWith(
        broadcastToken: data.broadcastToken,
      );

      return Right(broadcastWithToken);
    } on DioException catch (e) {
      final error = _handleDioException(e);
      return Left(error);
    } on TimeoutException {
      return const Left(BroadcastTimeoutException());
    }
  }

  @override
  Future<Either<BroadcastException, List<Participant?>>> liveParticipants(
    ID id,
  ) async {
    try {
      final response = await _remote.getLiveParticipants(id: id.getOrCrash());
      final participants = response.data!.map((e) => e.toDomain).toList();
      return Right(participants);
    } on DioException catch (e) {
      final error = _handleDioException(e);
      return Left(error);
    } on TimeoutException {
      return const Left(BroadcastTimeoutException());
    }
  }

  @override
  Future<Either<BroadcastException, List<Participant?>>> participants(
    ID id,
  ) async {
    try {
      final response = await _remote.getParticipants(id: id.getOrCrash());
      final data = response.data!;
      final participants = data.participants.map((e) => e?.toDomain).toList();
      return Right(participants);
    } on DioException catch (e) {
      final error = _handleDioException(e);
      return Left(error);
    } on TimeoutException {
      return const Left(BroadcastTimeoutException());
    }
  }

  @override
  Future<Either<BroadcastException, Broadcast>> startBroadcast(ID id) async {
    try {
      final response = await _remote.startBroadcast(id: id.getOrCrash());
      return Right(response.data!.toDomain);
    } on DioException catch (e) {
      final error = _handleDioException(e);
      return Left(error);
    } on TimeoutException {
      return const Left(BroadcastTimeoutException());
    }
  }
}

BroadcastException _handleDioException(DioException error) {
  final errorData = error.response?.data;

  if (errorData == null) return const BroadcastUnknownException();

  final baseError = errorData as Map<String, dynamic>;
  final base = BaseResponse.fromJson(baseError, (_) => null);

  return switch (base.error) {
    final Map<String, dynamic> errors => BroadcastValidationException(errors),
    _ => BroadcastExceptionWithMessage(base.message ?? 'Unknown error'),
  };
}
