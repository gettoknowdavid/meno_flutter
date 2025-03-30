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
    : _storage = storage;
  final SecureStorageService _storage;

  Map<String, UserCredentialDto> accounts = {};
  UserCredentialDto? currentAccount;

  Future<void> addAccount(
    UserCredentialDto? credential, {
    bool isCurrent = true,
  }) async {
    if (credential == null) return;

    final userId = credential.user.id;
    accounts[userId] = credential.stripped;

    // Store map of auth user's id to the token for convenience in retrieving
    // token for API calls through Dio
    final encodedString = jsonEncode({userId: credential.token});
    await _storage.write(AuthStorageKeys.currentAccount, value: encodedString);

    await _storage.write(AuthStorageKeys.authUserId, value: userId);
    await _saveAccountsMap(accounts);
  }

  Future<UserCredentialDto?> getCurrentAccount() async {
    if (currentAccount != null) return currentAccount;

    final userId = await _storage.read(AuthStorageKeys.authUserId);
    if (userId == null) return null;
    return getAccountById(userId);
  }

  UserCredentialDto? getAccountById(String userId) => accounts[userId];

  Future<void> removeAccount(String? userId) async {
    if (userId == null) return;

    if (userId == currentAccount?.user.id) {
      await _storage.delete(AuthStorageKeys.authUserId);
      await _storage.delete(AuthStorageKeys.currentAccount);
    }
    
    accounts.remove(userId);
    await _saveAccountsMap(accounts);
  }

  Future<Map<String, UserCredentialDto>> getAllAccounts() async {
    if (accounts.isNotEmpty) return accounts;

    final encodedString = await _storage.read(AuthStorageKeys.accounts);
    if (encodedString?.isEmpty ?? true) return {};

    final decodedMap = jsonDecode(encodedString!) as Map<String, dynamic>?;
    if (decodedMap == null) return {};

    final map = decodedMap.map<String, UserCredentialDto>((key, value) {
      final userData = value as Map<String, dynamic>;
      return MapEntry(key, UserCredentialDto.fromJson(userData));
    });

    accounts = map;
    return map;
  }

  Future<void> _saveAccountsMap(Map<String, UserCredentialDto> map) async {
    final encodedString = jsonEncode(map);
    return _storage.write(AuthStorageKeys.accounts, value: encodedString);
  }
}
