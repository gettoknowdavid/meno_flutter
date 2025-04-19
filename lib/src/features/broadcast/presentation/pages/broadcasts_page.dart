import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/config/config.dart' show OrderBy, kPageSize;
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/shared/shared.dart' show CurrentUserAvatar;

class BroadcastsPage extends HookConsumerWidget {
  const BroadcastsPage({
    required this.type,
    required this.sortBy,
    required this.orderBy,
    this.page = 1,
    this.size = kPageSize,
    this.endTimeExists,
    this.include,
    super.key,
  });

  final BroadcastsPageType type;
  final int page;
  final int size;
  final String sortBy;
  final OrderBy orderBy;
  final bool? endTimeExists;
  final String? include;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final broadcasts = ref.watch(
      broadcastsProvider(
        sortBy: sortBy,
        orderBy: orderBy,
        endTimeExists: endTimeExists,
      ),
    );

    return Scaffold(
      appBar: MenoTopBar.secondary(
        title: type.title,
        centerTitle: true,
        actions: const [CurrentUserAvatar()],
      ),
      body: Column(
        children: [
          const MenoSpacer.v(24),
          const _SearchBar(key: Key('BroadcastsPageSearchBar')),
          const MenoSpacer.v(2),
          Expanded(
            child: switch (type) {
              BroadcastsPageType.recently => RecentlyLiveBroadcastsListWidget(
                key: const Key('RecentlyLiveBroadcastsList'),
                broadcasts: broadcasts,
              ),
              _ => Container(),
            },
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends HookConsumerWidget {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);

    final focusNode = useFocusNode();
    final debounce = useRef<Timer?>(null);

    useEffect(() {
      return debounce.value?.cancel;
    }, const []);

    void onSearchChange(String query) {
      // Cancel the previous timer if it exists
      if (debounce.value?.isActive ?? false) debounce.value!.cancel();

      // Start a new timer
      debounce.value = Timer(const Duration(milliseconds: 400), () {
        // When the timer fires (user stopped typing), update the search
        ref.read(keywordsProvider.notifier).state = query;
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
      child: SearchBar(
        focusNode: focusNode,
        scrollPadding: EdgeInsets.zero,
        hintText: 'Search broadcasts',
        onChanged: onSearchChange,
        leading: Icon(MIcons.search, color: colors.labelPlaceholder, size: 16),
      ),
    );
  }
}

enum BroadcastsPageType { recently, now, forYou }

extension BroadcastsPageTypeX on BroadcastsPageType {
  String get title {
    return switch (this) {
      BroadcastsPageType.recently => 'Recently Live',
      BroadcastsPageType.now => 'Now Live',
      BroadcastsPageType.forYou => 'Live For You',
    };
  }
}
