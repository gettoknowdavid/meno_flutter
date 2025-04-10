import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/config/env/env.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'broadcast_providers.g.dart';

@riverpod
IBroadcastFacade broadcastFacade(Ref ref) {
  final baseUrl = ref.read(menoUrlProvider);
  final dio = ref.read(dioProvider(baseUrl));
  final remote = BroadcastRemoteDatasource(dio, baseUrl: baseUrl);
  return BroadcastFacade(remote: remote);
}
