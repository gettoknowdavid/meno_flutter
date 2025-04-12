import 'package:permission_handler/permission_handler.dart'
    show PermissionStatus;

/// [MenoPermissionStatus] is a copy of the [PermissionStatus] from
/// `permission_handler`.
///
enum MenoPermissionStatus {
  /// The user denied access to the requested feature, permission needs to be
  /// asked first.
  denied,

  /// The user granted access to the requested feature.
  granted,

  /// The OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  ///
  /// *Only supported on iOS.*
  restricted,

  /// The user has authorized this application for limited access. So far this
  /// is only relevant for the Photo Library picker.
  ///
  /// *Only supported on iOS (iOS14+) and Android (Android 14+)*
  limited,

  /// Permission to the requested feature is permanently denied, the permission
  /// dialog will not be shown when requesting this permission. The user may
  /// still change the permission status in the settings.
  ///
  /// *On Android:*
  /// Android 11+ (API 30+): whether the user denied the permission for a second
  /// time.
  /// Below Android 11 (API 30): whether the user denied access to the requested
  /// feature and selected to never again show a request.
  ///
  /// *On iOS:*
  /// If the user has denied access to the requested feature.
  permanentlyDenied,

  /// The application is provisionally authorized to post non-interruptive user
  /// notifications.
  ///
  /// *Only supported on iOS (iOS12+).*
  provisional,
}

/// Utility getter extensions for the [MenoPermissionStatus] type.
extension MenoPermissionStatusGetters on MenoPermissionStatus {
  /// If the user denied access to the requested feature.
  bool get isDenied => this == MenoPermissionStatus.denied;

  /// If the user granted access to the requested feature.
  bool get isGranted => this == MenoPermissionStatus.granted;

  /// If the OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  ///
  /// *Only supported on iOS.*
  bool get isRestricted => this == MenoPermissionStatus.restricted;

  /// If the permission to the requested feature is permanently denied, the
  /// permission dialog will not be shown when requesting this permission. The
  /// user may still change the permission status in the settings.
  ///
  /// *On Android:*
  /// Android 11+ (API 30+): whether the user denied the permission for a second
  /// time.
  /// Below Android 11 (API 30): whether the user denied access to the requested
  /// feature and selected to never again show a request.
  /// The user may still change the permission status in the settings.
  ///
  /// *On iOS:*
  /// If the user has denied access to the requested feature.
  bool get isPermanentlyDenied =>
      this == MenoPermissionStatus.permanentlyDenied;

  /// If the user has authorized this application for limited access. So far
  /// this is only relevant for the Photo Library picker.
  ///
  /// *Only supported on iOS (iOS14+).*
  bool get isLimited => this == MenoPermissionStatus.limited;

  /// If the application is provisionally authorized to post non-interruptive
  /// user notifications.
  ///
  /// *Only supported on iOS (iOS12+).*
  bool get isProvisional => this == MenoPermissionStatus.provisional;
}

/// Utility getter extensions for the `Future<MenoPermissionStatus>` type.
extension FutureMenoPermissionStatusGetters on Future<MenoPermissionStatus> {
  /// If the user granted access to the requested feature.
  Future<bool> get isGranted async => (await this).isGranted;

  /// If the user denied access to the requested feature.
  Future<bool> get isDenied async => (await this).isDenied;

  /// If the OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  ///
  /// *Only supported on iOS.*
  Future<bool> get isRestricted async => (await this).isRestricted;

  /// If the permission to the requested feature is permanently denied, the
  /// permission dialog will not be shown when requesting this permission. The
  /// user may still change the permission status in the settings.
  ///
  /// *On Android:*
  /// Android 11+ (API 30+): whether the user denied the permission for a second
  /// time.
  /// Below Android 11 (API 30): whether the user denied access to the requested
  /// feature and selected to never again show a request.
  ///
  /// *On iOS:*
  /// If the user has denied access to the requested feature.
  Future<bool> get isPermanentlyDenied async =>
      (await this).isPermanentlyDenied;

  /// If the user has authorized this application for limited access. So far
  /// this is only relevant for the Photo Library picker.
  ///
  /// *Only supported on iOS (iOS14+).*
  Future<bool> get isLimited async => (await this).isLimited;

  /// If the application is provisionally authorized to post non-interruptive
  /// user notifications.
  ///
  /// *Only supported on iOS (iOS12+).*
  Future<bool> get isProvisional async => (await this).isProvisional;
}
