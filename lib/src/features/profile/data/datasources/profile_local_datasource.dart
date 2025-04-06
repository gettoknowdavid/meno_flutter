import 'dart:convert';

import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/services/services.dart';

class ProfileLocalDatasource {
  const ProfileLocalDatasource({required SecureStorageService storage})
    : _storage = storage;

  final SecureStorageService _storage;
  Future<void> deleteProfile() => _storage.delete(ProfileKeys.myProfile);

  Future<ProfileDto?> getProfile() async {
    try {
      final encodedString = await _storage.read(ProfileKeys.myProfile);
      if (encodedString?.isEmpty ?? true) return null;

      final json = jsonDecode(encodedString!) as Map<String, dynamic>;
      return ProfileDto.fromJson(json);
    } on Exception {
      rethrow;
    }
  }

  Future<void> saveProfile(ProfileDto profile) async {
    try {
      final value = jsonEncode(profile.stripped);
      await _storage.write(ProfileKeys.myProfile, value: value);
    } on Exception {
      rethrow;
    }
  }
}
