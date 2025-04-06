import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/config/env/env.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/services/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_facade_provider.g.dart';

@riverpod
IProfileFacade profileFacade(Ref ref) {
  final storage = ref.read(secureStorageProvider);
  final local = ProfileLocalDatasource(storage: storage);

  final baseUrl = ref.read(menoUrlProvider);
  final dio = ref.read(dioProvider(baseUrl));
  final remote = ProfileRemoteDatasource(dio, baseUrl: baseUrl);

  return ProfileFacade(remote: remote, local: local);
}
