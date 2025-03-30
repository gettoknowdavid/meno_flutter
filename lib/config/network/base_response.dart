import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse({
    required int statusCode,
    @Default('') String message,
    @Default(false) bool success,
    @Default(false) bool status,
    T? data,
    String? path,
    dynamic error,
  }) = _BaseResponse;

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$BaseResponseFromJson(json, fromJsonT);
}
