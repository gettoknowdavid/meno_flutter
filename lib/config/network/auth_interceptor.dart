//
//ignore_for_file: cascade_invocations, strict_raw_type

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meno_flutter/config/config.dart';
import 'package:meno_flutter/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_interceptor.g.dart';

@riverpod
AuthInterceptor authInterceptor(Ref ref) {
  final storage = ref.read(secureStorageProvider);
  return AuthInterceptor(storage: storage);
}

/// An interceptor for automatically adding an authorization token to requests
/// based on a stored user credential.
///
/// This interceptor retrieves the user credential from secure storage and, if
/// available, adds an "Authorization" header with a "Bearer" token to the
/// outgoing request. This helps to ensure requests are authenticated if a
/// valid token exists.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required SecureStorageService storage}) : _storage = storage;
  final SecureStorageService _storage;

  String? _cachedToken;

  @visibleForTesting
  String? get cachedToken => _cachedToken;

  /// Removes only the expired user from storage without affecting others
  Future<void> _forceLogout(String userId) async {
    final accountsJson = await _storage.read(AuthStorageKeys.accounts);
    if (accountsJson != null) {
      final accounts = jsonDecode(accountsJson) as Map<String, dynamic>;
      accounts.remove(userId);

      final updatedAccounts = jsonEncode(accounts);
      await _storage.write(AuthStorageKeys.accounts, value: updatedAccounts);
    }

    // Remove current user if it's the same as the expired one
    final currentUserJson = await _storage.read(AuthStorageKeys.currentAccount);
    if (currentUserJson != null) {
      final currentUser = jsonDecode(currentUserJson) as Map<String, dynamic>;
      if (currentUser.keys.first == userId) {
        await _storage.delete(AuthStorageKeys.currentAccount);
      }
    }

    _cachedToken = null;
  }

  /// Retrieves the latest token from the [SecureStorageService]
  Future<String?> _getToken() async {
    if (_cachedToken != null) return _cachedToken;

    final currentUserJson = await _storage.read(AuthStorageKeys.currentAccount);
    if (currentUserJson == null) return null;

    final currentUser = jsonDecode(currentUserJson) as Map<String, dynamic>;
    if (currentUser.isEmpty) return null;

    final currentUserId = currentUser.keys.first;
    final token = currentUser[currentUserId] as String?;

    if (token != null && !JwtDecoder.isExpired(token)) {
      _cachedToken = token;
      return token;
    } else {
      await _forceLogout(currentUserId);
      return null;
    }
  }

  /// Handles errors that occur during the HTTP request/response lifecycle.
  ///
  /// This method is typically overridden to implement custom error handling
  /// logic. In this case, we simply delegate to the superclass implementation.
  @override
  Future<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    return super.onError(err, handler);
  }

  /// Modifies the request options before sending a request.
  ///
  /// This method allows you to intercept the request and potentially modify
  /// the options before it is sent. Here, we retrieve the stored user
  /// credential, if present, and add an "Authorization" header with a "Bearer"
  /// token to the request options.
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra['requestType'] == RequestType.unprotected) {
      return super.onRequest(options, handler);
    }

    final token = await _getToken();
    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    return super.onRequest(options, handler);
  }
}
