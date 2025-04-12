import 'package:meno_flutter/src/services/permissions/meno_permission_status.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permissions_service.g.dart';

@riverpod
PermissionsService permissions(Ref ref) => PermissionsService();

@riverpod
class MicrophonePermissions extends _$MicrophonePermissions {
  PermissionsService get _permissions => ref.read(permissionsProvider);

  @override
  FutureOr<MenoPermissionStatus> build() => _permissions.microphoneStatus;

  Future<void> checkAndRequest() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final currentStatus = await _permissions.microphoneStatus;

      if (currentStatus.isGranted) {
        return currentStatus;
      } else if (currentStatus.isPermanentlyDenied) {
        return currentStatus;
      } else {
        return _permissions.requestMicrophonePermission();
      }
    });
  }

  Future<void> openSettings() => _permissions.openSettings();
}

class PermissionsService {
  /// Checks the current status of the microphone permission.
  Future<MenoPermissionStatus> get microphoneStatus async {
    final result = await Permission.microphone.status;
    return result.menoStatus;
  }

  /// Requests microphone permission from the user.
  /// Returns the status AFTER the request attempt.
  Future<MenoPermissionStatus> requestMicrophonePermission() async {
    final result = await Permission.microphone.request();
    return result.menoStatus;
  }

  /// Checks the current status of the notification permission.
  Future<MenoPermissionStatus> get notificationStatus async {
    final result = await Permission.notification.status;
    return result.menoStatus;
  }

  /// Requests notification permission from the user.
  Future<MenoPermissionStatus> requestNotificationPermission() async {
    final result = await Permission.notification.request();
    return result.menoStatus;
  }

  /// Opens the application's settings page in the OS.
  Future<bool> openSettings() => openAppSettings();
}

extension PermissionsServiceX on PermissionStatus {
  MenoPermissionStatus get menoStatus {
    return switch (this) {
      PermissionStatus.granted => MenoPermissionStatus.granted,
      PermissionStatus.denied => MenoPermissionStatus.denied,
      PermissionStatus.permanentlyDenied =>
        MenoPermissionStatus.permanentlyDenied,
      PermissionStatus.restricted => MenoPermissionStatus.restricted,
      PermissionStatus.limited => MenoPermissionStatus.limited,
      PermissionStatus.provisional => MenoPermissionStatus.provisional,
    };
  }
}
