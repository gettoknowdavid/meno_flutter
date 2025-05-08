import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meno_flutter/src/config/config.dart' show BaseResponse;
import 'package:meno_flutter/src/config/constants/order_by.dart';
import 'package:meno_flutter/src/config/network/paginated_data_types.dart';
import 'package:meno_flutter/src/features/chat/chat.dart';
import 'package:meno_flutter/src/shared/domain/value_objects/id.dart';

class ChatFacade implements IChatFacade {
  const ChatFacade({required ChatRemoteDatasource remote}) : _remote = remote;
  final ChatRemoteDatasource _remote;

  @override
  Future<Either<ChatException, PaginatedList<Chat?>>> getChatMessages({
    required ID broadcastId,
    OrderBy? orderBy = OrderBy.DESC,
    int? page = 1,
    int? size = 50,
  }) async {
    try {
      final response = await _remote.chatMessages(
        broadcastId: broadcastId.getOrCrash(),
        orderBy: orderBy?.lowercaseName,
        page: page,
        size: size,
      );
      final data = response.data!;
      final paginatedList = PaginatedList(
        items: data.chatMessages.map((dto) => dto?.toDomain).toList(),
        currentPage: data.currentPage,
        totalItems: data.totalItems,
        totalPages: data.totalPages,
      ); 
      return right(paginatedList);
    } on DioException catch (e) {
      final error = _handleDioException(e);
      return Left(error);
    } on TimeoutException {
      return const Left(ChatTimeoutException());
    }
  }
}

ChatException _handleDioException(DioException error) {
  final errorData = error.response?.data;

  if (errorData == null) return const ChatUnknownException();

  final baseError = errorData as Map<String, dynamic>;
  final base = BaseResponse.fromJson(baseError, (_) => null);

  return switch (base.error) {
    final Map<String, dynamic> errors => ChatValidationException(errors),
    _ => ChatExceptionWithMessage(base.message ?? 'Unknown error'),
  };
}
