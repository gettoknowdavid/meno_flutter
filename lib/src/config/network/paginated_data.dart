import 'package:equatable/equatable.dart';

class PaginatedData<T> with EquatableMixin {
  const PaginatedData({
    required this.items,
    required this.totalPages,
    required this.totalItems,
    required this.currentPage,
  });

  factory PaginatedData.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
    String listKey,
  ) {
    return PaginatedData<T>(
      items: (json[listKey] as List<dynamic>).map(fromJsonT).toList(),
      totalPages: json['totalPages'] as int,
      totalItems: json['totalItems'] as int,
      currentPage: json['currentPage'] as int,
    );
  }

  final List<T> items;
  final int totalPages;
  final int totalItems;
  final int currentPage;

  @override
  List<Object?> get props => [items, totalPages, totalItems, currentPage];

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
    String listKey,
  ) => {
    listKey: items.map(toJsonT).toList(),
    'totalPages': totalPages,
    'totalItems': totalItems,
    'currentPage': currentPage,
  };
}
