import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meno_flutter/config/config.dart';
import 'package:meno_flutter/features/auth/data/data.dart';
import 'package:meno_flutter/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_local_datasource.g.dart';

@riverpod
AuthLocalDatasource authLocal(Ref ref) {
  final storage = ref.read(secureStorageProvider);
  return AuthLocalDatasource(storage: storage);
}

class AuthLocalDatasource {
  AuthLocalDatasource({required SecureStorageService storage})
    : _storage = storage {
    getAllAccounts();
  }

  final SecureStorageService _storage;

  final Map<String, UserCredentialDto> _cachedAccounts = {};

  Future<void> addAccount(
    UserCredentialDto credential, {
    bool rememberMe = false,
  }) async {
    final userId = credential.user.id;
    try {
      // Store the user's id
      await _storage.write(AuthStorageKeys.currentUserId, value: userId);

      if (rememberMe) {
        // Store the current user's data for without token for easy login
        final userData = jsonEncode(credential.user.stripped);
        await _storage.write(AuthStorageKeys.rememberedUser, value: userData);
      }

      // Store a stripped version of the user's credential using the user's id
      _cachedAccounts[userId] = credential.stripped;
      await _saveAccountsMap(_cachedAccounts);
    } on Exception {
      rethrow;
    }
  }

  Future<void> clearAllAccounts() async {
    _cachedAccounts.clear();
    try {
      await _storage.deleteAll();
    } on Exception {
      rethrow;
    }
  }

  Future<UserCredentialDto?> getAccountById(String userId) async {
    if (_cachedAccounts.isNotEmpty) return _cachedAccounts[userId];
    final allAccountsMap = await getAllAccounts();
    return allAccountsMap[userId];
  }

  Future<Map<String, UserCredentialDto>> getAllAccounts() async {
    if (_cachedAccounts.isNotEmpty) return _cachedAccounts;

    try {
      final encodedString = await _storage.read(AuthStorageKeys.allAccounts);
      if (encodedString?.isEmpty ?? true) return {};

      final decodedMap = jsonDecode(encodedString!) as Map<String, dynamic>;

      final map = decodedMap.map<String, UserCredentialDto>((key, value) {
        final userData = value as Map<String, dynamic>;
        return MapEntry(key, UserCredentialDto.fromJson(userData));
      });

      _cachedAccounts.addAll(map);
      return _cachedAccounts;
    } on Exception {
      rethrow;
    }
  }

  Future<String?> getAuthenticatedUserId() async {
    return _storage.read(AuthStorageKeys.currentUserId);
  }

  Future<UserCredentialDto?> getCurrentAccount() async {
    final userId = await _storage.read(AuthStorageKeys.currentUserId);
    if (userId == null) return null;
    if (_cachedAccounts.isNotEmpty) return _cachedAccounts[userId];
    return getAccountById(userId);
  }

  Future<void> removeAccount([String? userId]) async {
    try {
      if (userId == null) {
        final currentUserId = await getAuthenticatedUserId();
        _cachedAccounts.remove(currentUserId);

        await _storage.delete(AuthStorageKeys.currentUserId);
        await _saveAccountsMap(_cachedAccounts);
      } else {
        _cachedAccounts.remove(userId);
        await _saveAccountsMap(_cachedAccounts);
      }
    } on Exception {
      rethrow;
    }
  }

  Future<void> _saveAccountsMap(Map<String, UserCredentialDto> map) async {
    try {
      final value = jsonEncode(map.map((key, v) => MapEntry(key, v.toJson())));
      return _storage.write(AuthStorageKeys.allAccounts, value: value);
    } on Exception {
      rethrow;
    }
  }
}
