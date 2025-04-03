//
//ignore_for_file: cascade_invocations, strict_raw_type

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/services/services.dart';

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
  Future<void> _forceLogout() async {
    _cachedToken = null;

    final currentUserId = await _storage.read(AuthStorageKeys.currentUserId);
    final accountsJson = await _storage.read(AuthStorageKeys.allAccounts);

    if (accountsJson != null && currentUserId != null) {
      final allAccounts = jsonDecode(accountsJson) as Map<String, dynamic>;
      allAccounts.remove(currentUserId);
      final updatedAccounts = jsonEncode(allAccounts);
      await _storage.write(AuthStorageKeys.allAccounts, value: updatedAccounts);
    }

    // Remove current user if it's the same as the expired one
    await _storage.delete(AuthStorageKeys.currentUserId);
  }

  /// Retrieves the latest token from the [SecureStorageService]
  Future<String?> _getToken() async {
    if (_cachedToken != null && !JwtDecoder.isExpired(_cachedToken!)) {
      return _cachedToken;
    }

    final userId = await _storage.read(AuthStorageKeys.currentUserId);
    final allAccountsString = await _storage.read(AuthStorageKeys.allAccounts);

    if (allAccountsString?.isEmpty ?? false) return null;

    final decodedMap = jsonDecode(allAccountsString!) as Map<String, dynamic>;
    final accountsMap = decodedMap.map<String, UserCredentialDto>((key, value) {
      final userData = value as Map<String, dynamic>;
      return MapEntry(key, UserCredentialDto.fromJson(userData));
    });

    final token = accountsMap[userId]?.token;
    if (token != null && !JwtDecoder.isExpired(token)) {
      return _cachedToken = token;
    } else {
      await _forceLogout();
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

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(response.data?.toString() ?? 'Nothing returned');
    super.onResponse(response, handler);
  }
}
