import 'package:envied/envied.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'env.g.dart';

@riverpod
String menoUrl(Ref ref) => Env.menoApiUrl;

@riverpod
String bibleUrl(Ref ref) => Env.bibleApiUrl;

@riverpod
String livekitUrl(Ref ref) => Env.menoLiveKitUrl;

@Envied(name: 'Env', path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'MENO_API_URL')
  static final String menoApiUrl = _Env.menoApiUrl;

  @EnviedField(varName: 'BIBLE_API_URL')
  static final String bibleApiUrl = _Env.bibleApiUrl;

  @EnviedField(varName: 'MENO_LIVEKIT_URL')
  static final String menoLiveKitUrl = _Env.menoLiveKitUrl;
}
