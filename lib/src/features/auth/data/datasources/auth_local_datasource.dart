import 'dart:async';
import 'dart:convert';

import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/auth/data/data.dart';
import 'package:meno_flutter/src/services/services.dart';

class AuthLocalDatasource {
  AuthLocalDatasource({required SecureStorageService storage})
    : _storage = storage {
    _initialize();
  }

  final SecureStorageService _storage;

  final Map<String, UserCredentialDto> _cachedAccounts = {};
  final _currentAccountController =
      StreamController<UserCredentialDto?>.broadcast();
  final _allAccountsController =
      StreamController<Map<String, UserCredentialDto>>.broadcast();

  Stream<UserCredentialDto?> get authStateChanges {
    return _currentAccountController.stream.asBroadcastStream();
  }

  Stream<Map<String, UserCredentialDto>> get allAccountsStream {
    return _allAccountsController.stream.asBroadcastStream();
  }

  Future<void> _initialize() async {
    try {
      await getAllAccounts().then((allAccounts) async {
        _allAccountsController.add(allAccounts);

        final currentAccount = await getCurrentAccount();
        _currentAccountController.add(currentAccount);
      });
    } on Exception {
      _currentAccountController.add(null);
    }
  }

  Future<void> addAccount(
    UserCredentialDto credential, {
    bool rememberMe = false,
  }) async {
    _currentAccountController.add(credential);

    final userId = credential.user.id;
    final token = credential.token;
    try {
      // Store the user's id
      await _storage.write(AuthStorageKeys.currentUserId, value: userId);

      // Store the user's authentication token
      await _storage.write(AuthStorageKeys.currentUserToken, value: token);

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
    _currentAccountController.add(null);
    _cachedAccounts.clear();
    try {
      await _storage.delete(AuthStorageKeys.allAccounts);
      await _storage.delete(AuthStorageKeys.currentUserId);
      await _storage.delete(AuthStorageKeys.currentUserToken);
      await _storage.delete(AuthStorageKeys.rememberedUser);
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

  Future<void> logout() async {
    _currentAccountController.add(null);
    await _storage.delete(AuthStorageKeys.currentUserId);
  }

  Future<void> removeAccount([String? userId]) async {
    _currentAccountController.add(null);
    try {
      if (userId == null) {
        final currentUserId = await getAuthenticatedUserId();
        _cachedAccounts.remove(currentUserId);

        await _storage.delete(AuthStorageKeys.currentUserId);
        await _storage.delete(AuthStorageKeys.currentUserToken);
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

  Future<void> dispose() async {
    await _currentAccountController.close();
  }
}
