//
// ignore_for_file: one_member_abstracts

import 'package:dartz/dartz.dart';
import 'package:meno_flutter/src/config/config.dart'
    show OrderBy, PaginatedList;
import 'package:meno_flutter/src/features/chat/chat.dart';
import 'package:meno_flutter/src/shared/shared.dart' show ID;

abstract class IChatFacade {
  Future<Either<ChatException, PaginatedList<Chat?>>> getChatMessages({
    required ID broadcastId,
    OrderBy? orderBy = OrderBy.DESC,
    int? page = 1,
    int? size = 50,
  });
}
