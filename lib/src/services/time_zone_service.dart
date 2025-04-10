import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_zone_service.g.dart';

@riverpod
FutureOr<String> timezone(Ref ref) => FlutterTimezone.getLocalTimezone();
