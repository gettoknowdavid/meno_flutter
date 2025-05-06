// 
// ignore_for_file: one_member_abstracts

import 'package:dio/dio.dart';
import 'package:meno_flutter/src/config/network/network.dart';
import 'package:meno_flutter/src/features/chat/chat.dart';
import 'package:retrofit/retrofit.dart';

part 'chat_remote_datasource.g.dart';

@RestApi()
abstract class ChatRemoteDatasource {
  /// Creates a new `ChatRemoteDatasource` object.
  factory ChatRemoteDatasource(Dio dio, {String baseUrl}) =
      _ChatRemoteDatasource;

  @GET('/api/v1/chat-messages')
  Future<BaseResponse<PaginatedChatMessages<ChatDto?>>> chatMessages({
    @Query('broadcastId') required String broadcastId,
    @Query('orderBy') String? orderBy,
    @Query('page') int? page,
    @Query('size') int? size,
  });
}
