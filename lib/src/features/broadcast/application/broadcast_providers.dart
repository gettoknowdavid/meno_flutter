//
// ignore_for_file: avoid_redundant_argument_values

import 'package:dio/dio.dart' show CancelToken;
import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/config/env/env.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'broadcast_providers.g.dart';

final keywordsProvider = StateProvider.autoDispose<String>((_) => '');

@riverpod
IBroadcastFacade broadcastFacade(Ref ref) {
  final baseUrl = ref.read(menoUrlProvider);
  final dio = ref.read(dioProvider(baseUrl));
  final remote = BroadcastRemoteDatasource(dio, baseUrl: baseUrl);
  return BroadcastFacade(remote: remote);
}

@riverpod
class Broadcasts extends _$Broadcasts {
  // Keep track of ongoing fetch operations to prevent duplicates
  CancelToken? _cancelToken;

  @override
  FutureOr<BroadcastsState> build({
    required String sortBy,
    required OrderBy orderBy,
    bool? endTimeExists,
  }) async {
    final keywords = ref.watch(keywordsProvider);

    // Cancel previous operations when the notifier is rebuilt
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    // The initial build fetches the first page
    final initialState = await _fetch(
      page: 1,
      sortBy: sortBy,
      orderBy: orderBy,
      keywords: keywords.isEmpty ? null : keywords,
      cancelToken: _cancelToken,
    );

    ref.onDispose(() => _cancelToken?.cancel());

    return initialState;
  }

  Future<BroadcastsState> _fetch({
    required int page,
    required String sortBy,
    required OrderBy orderBy,
    String? keywords,
    CancelToken? cancelToken,
  }) async {
    final facade = ref.read(broadcastFacadeProvider);

    final result = await facade.getBroadcasts(
      page: page,
      sortBy: sortBy,
      orderBy: orderBy,
      keywords: keywords,
      endTimeExist: endTimeExists,
      include: 'totalListeners',
      cancelToken: cancelToken,
    );

    return result.fold(
      (exception) => throw exception,
      (broadcasts) => BroadcastsState(
        broadcasts: broadcasts.items,
        currentPage: broadcasts.currentPage,
        totalPages: broadcasts.totalPages,
        moreInProgress: false,
        hasMore: broadcasts.currentPage < broadcasts.totalPages,
      ),
    );
  }

  Future<void> fetchMore() async {
    // Ensure previous state was successful data
    final oldState = state.valueOrNull;
    if (oldState == null) return;

    // Prevent multiple simultaneous fetches and fetching beyond the last page
    if (oldState.moreInProgress || !oldState.hasMore) return;

    final keywords = ref.watch(keywordsProvider);

    // Cancel previous token if any and create a new one
    _cancelToken?.cancel();
    final pageCancelToken = CancelToken();
    _cancelToken = pageCancelToken;

    // Set loading state for the next page
    state = AsyncData(oldState.copyWith(moreInProgress: true, exception: null));

    final nextPage = oldState.currentPage + 1;

    try {
      final facade = ref.read(broadcastFacadeProvider);
      final result = await facade.getBroadcasts(
        page: nextPage,
        keywords: keywords.isEmpty ? null : keywords,
        sortBy: sortBy,
        orderBy: orderBy,
        endTimeExist: endTimeExists,
        include: 'totalListeners',
        cancelToken: pageCancelToken,
      );

      result.fold(
        (exception) {
          state = AsyncData(
            oldState.copyWith(moreInProgress: false, exception: exception),
          );
        },
        (paginatedList) {
          state = AsyncData(
            oldState.copyWith(
              broadcasts: [...oldState.broadcasts, ...paginatedList.items],
              currentPage: paginatedList.currentPage,
              totalPages: paginatedList.totalPages,
              hasMore: paginatedList.currentPage < paginatedList.totalPages,
              moreInProgress: false,
              exception: null,
            ),
          );
        },
      );
    } finally {
      // Cancel the token when done
      if (_cancelToken == pageCancelToken) _cancelToken = null;
    }
  }

  // Example method for pull-to-refresh
  Future<void> refresh() async => ref.invalidateSelf();
}

final class BroadcastsState with EquatableMixin {
  BroadcastsState({
    required this.broadcasts,
    required this.currentPage,
    required this.moreInProgress,
    required this.hasMore,
    this.totalPages,
    this.exception,
  });

  final List<Broadcast?> broadcasts;
  final int currentPage;
  final int? totalPages;
  final bool moreInProgress;
  final bool hasMore;
  final BroadcastException? exception;

  @override
  List<Object?> get props => [
    broadcasts,
    currentPage,
    totalPages,
    moreInProgress,
    hasMore,
    exception,
  ];
  BroadcastsState copyWith({
    List<Broadcast?>? broadcasts,
    int? currentPage,
    int? totalPages,
    bool? moreInProgress,
    bool? hasMore,
    BroadcastException? exception,
  }) {
    return BroadcastsState(
      broadcasts: broadcasts ?? this.broadcasts,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      moreInProgress: moreInProgress ?? this.moreInProgress,
      hasMore: hasMore ?? this.hasMore,
      exception: exception ?? this.exception,
    );
  }
}
