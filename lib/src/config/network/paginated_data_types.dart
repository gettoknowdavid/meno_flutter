import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_data_types.g.dart';

mixin Paginated<T> {
  List<T?> get items;
  int get totalPages;
  int get totalItems;
  int get currentPage;
}

final class PaginatedList<T> with EquatableMixin, Paginated<T> {
  const PaginatedList({
    required this.items,
    required this.currentPage,
    required this.totalItems,
    required this.totalPages,
  });

  @override
  final List<T?> items;

  @override
  final int currentPage;

  @override
  final int totalItems;

  @override
  final int totalPages;

  @override
  List<Object?> get props => [items, currentPage, totalItems, totalPages];

  @override
  bool? get stringify => true;
}

@JsonSerializable(genericArgumentFactories: true)
final class PaginatedProfileResponse<ProfileDto>
    with EquatableMixin, Paginated<ProfileDto?> {
  const PaginatedProfileResponse({
    required this.profiles,
    required this.totalPages,
    required this.totalItems,
    required this.currentPage,
  });

  factory PaginatedProfileResponse.fromJson(
    Map<String, dynamic> json,
    ProfileDto Function(Object?) fromJsonT,
  ) => _$PaginatedProfileResponseFromJson(json, fromJsonT);

  final List<ProfileDto?> profiles;

  @override
  List<ProfileDto?> get items => profiles;

  @override
  final int totalPages;

  @override
  final int totalItems;

  @override
  final int currentPage;

  @override
  List<Object?> get props => [profiles, totalItems, totalPages, currentPage];

  Map<String, dynamic> toJson(Object? Function(ProfileDto value) toJsonT) =>
      _$PaginatedProfileResponseToJson(this, toJsonT);

  @override
  bool? get stringify => true;
}

@JsonSerializable(genericArgumentFactories: true)
final class PaginatedChatMessages<ChatDto>
    with EquatableMixin, Paginated<ChatDto?> {
  const PaginatedChatMessages({
    required this.chatMessages,
    required this.totalPages,
    required this.totalItems,
    required this.currentPage,
  });

  factory PaginatedChatMessages.fromJson(
    Map<String, dynamic> json,
    ChatDto Function(Object?) fromJsonT,
  ) => _$PaginatedChatMessagesFromJson(json, fromJsonT);

  final List<ChatDto?> chatMessages;

  @override
  List<ChatDto?> get items => chatMessages;

  @override
  final int totalPages;

  @override
  final int totalItems;

  @override
  final int currentPage;

  @override
  List<Object?> get props => [
    chatMessages,
    totalItems,
    totalPages,
    currentPage,
  ];

  Map<String, dynamic> toJson(Object? Function(ChatDto value) toJsonT) =>
      _$PaginatedChatMessagesToJson(this, toJsonT);

  @override
  bool? get stringify => true;
}
