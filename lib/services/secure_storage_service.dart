import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_service.g.dart';

@riverpod
SecureStorageService secureStorage(Ref ref) => SecureStorageService();

/// A service for securely storing data on the device.
class SecureStorageService {
  /// Creates a new `SecureStorageService` object.
  SecureStorageService()
    : _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );

  /// The Flutter Secure Storage plugin.
  final FlutterSecureStorage _storage;

  /// Deletes the specified key from the secure storage.
  ///
  /// Returns a `Future` that completes when the key has been deleted.
  Future<void> delete(String key) => _storage.delete(key: key);

  /// Deletes all keys from the secure storage.
  ///
  /// Returns a `Future` that completes when all keys have been deleted.
  Future<void> deleteAll() => _storage.deleteAll();

  /// Checks whether the specified key exists in the secure storage.
  ///
  /// Returns a `Future` that completes to `true` if the key exists, or
  /// `false` otherwise.
  Future<bool> hasKey(String key) => _storage.containsKey(key: key);

  /// Reads the value of the specified key from the secure storage.
  ///
  /// Returns a `Future` that completes to the value of the key, or `null` if
  /// the key does not exist.
  Future<String?> read(String key) => _storage.read(key: key);

  /// Writes the specified value to the secure storage under the specified key.
  ///
  /// Returns a `Future` that completes when the value has been written.
  Future<void> write(String key, {required String? value}) {
    return _storage.write(key: key, value: value);
  }
}
