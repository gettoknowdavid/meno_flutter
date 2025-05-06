import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/src/config/env/env.dart';
import 'package:meno_flutter/src/config/network/network.dart';
import 'package:meno_flutter/src/features/chat/chat.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_facade_provider.g.dart';

@riverpod
IChatFacade chatFacade(Ref ref) {
  final baseUrl = ref.read(menoUrlProvider);
  final dio = ref.read(dioProvider(baseUrl));
  final remote = ChatRemoteDatasource(dio, baseUrl: baseUrl);
  return ChatFacade(remote: remote);
}
