import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/features/chat/chat.dart' show LiveChatTab;
import 'package:meno_flutter/src/routing/routing.dart';
import 'package:meno_flutter/src/services/live_kit/microphone.dart';
import 'package:meno_flutter/src/services/services.dart';

final _tabs = <int, MenoTab>{
  0: const MenoTab(key: Key('BroadcastTab'), text: 'Broadcast'),
  1: const MenoTab(key: Key('ChatTab'), text: 'Chat'),
  2: const MenoTab(key: Key('BibleTab'), text: 'Live Bible'),
  3: const MenoTab(key: Key('NotesTab'), text: 'Live Notes'),
};

class LiveSessionPage extends HookConsumerWidget {
  const LiveSessionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    // Listen for changes in the `LiveBroadcast` notifier
    ref.listen(liveBroadcastProvider, (previous, next) {
      if (previous?.status != next.status) {
        if (next.status == MenoLiveStatus.failure) {
          final message = next.exception!.message;
          MenoSnackBar.error(message);
        }

        if (next.status == MenoLiveStatus.started) {
          final broadcastToken = next.broadcast.broadcastToken;
          ref.read(liveKitProvider.notifier).broadcast(broadcastToken!);
        }

        if (next.status == MenoLiveStatus.ended) {
          ref.read(liveKitProvider.notifier).disconnect();
          final isMicEnabled = ref.read(microphoneProvider);
          log('IS MIC ENABLED? => $isMicEnabled');
          const HomeRoute().go(context);
        }
      }
    });

    ref.listen(liveKitProvider, (_, next) async {
      switch (next) {
        case AsyncError(:final error):
          final message = (error as LiveKitException).message;
          throw BroadcastExceptionWithMessage(message);
        case AsyncData(:final value):
          if (!(value?.isConnected ?? false)) return;

          final isMicEnabled = ref.read(microphoneProvider);
          log('IS MIC ENABLED? => $isMicEnabled');

          await ref.read(startedBroadcastEventProvider.notifier).emit();
        default:
      }
    });

    ref.listen(startedBroadcastEventProvider, (previous, next) {
      switch (next) {
        case AsyncError(:final error):
          ref.read(liveKitProvider.notifier).disconnect();

          final message = (error as SocketException).message;
          MenoSnackBar.error(message as String);

          final isMicEnabled = ref.read(microphoneProvider);
          log('IS MIC ENABLED? => $isMicEnabled');
        case AsyncData(:final value):
          if (value) {
            ref.read(participantsProvider.notifier).build();
          }
        default:
      }
    });

    final currentIndex = useState(0);

    final controller = useTabController(
      initialLength: _tabs.length,
      initialIndex: currentIndex.value,
      keys: _tabs.keys.map((key) => _tabs[key]!.key).toList(),
    );

    void handleNavigation(int index) {
      currentIndex.value = index;
      FocusScope.of(context).unfocus();
    }

    useEffect(() {
      if (currentIndex.value != controller.index) {
        controller.animateTo(currentIndex.value);
      }
      return null;
    }, [currentIndex, controller]);

    useEffect(() {
      void syncOnTabChange() {
        if (controller.index != currentIndex.value) {
          handleNavigation(controller.index);
        }
      }

      controller.addListener(syncOnTabChange);

      return () => controller.removeListener(syncOnTabChange);
    }, [controller, currentIndex]);

    return Stack(
      children: [
        Scaffold(
          appBar: _AppBar(
            key: const Key('LiveSessionLayoutAppBar'),
            controller: controller,
            onTabChanged: handleNavigation,
          ),
          body: MenoTabBarView(
            controller: controller,
            onPageChanged: (_) => FocusScope.of(context).unfocus(),
            children: const [
              LiveBroadcastTab(),
              LiveChatTab(),
              LiveBibleTab(),
              LiveNotesTab(),
            ],
          ),
        ),
        const _LoadingIndicatorOverlay(),
      ],
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.controller, super.key, this.onTabChanged});
  final TabController controller;
  final void Function(int)? onTabChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        child: MenoTabBar.normal(
          controller: controller,
          onTap: onTabChanged,
          tabs: _tabs.values.map((tab) => tab).toList(),
          padding: EdgeInsets.zero,
          isScrollable: false,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _LoadingIndicatorOverlay extends HookConsumerWidget {
  const _LoadingIndicatorOverlay()
    : super(key: const Key('LiveSessionLoadingOverlay'));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    ref.listen(liveBroadcastProvider, (previous, next) {
      if (previous != next) {
        isLoading.value = [
          MenoLiveStatus.inProgress,
          MenoLiveStatus.connecting,
        ].contains(next.status);
      }
    });

    ref.listen(startedBroadcastEventProvider, (previous, next) {
      switch (next) {
        case AsyncLoading():
          isLoading.value = true;
        default:
          isLoading.value = false;
      }
    });

    ref.listen(liveKitProvider, (_, next) async {
      switch (next) {
        case AsyncLoading():
          isLoading.value = true;
        default:
          isLoading.value = false;
      }
    });

    if (!isLoading.value) return const SizedBox.shrink();

    return ColoredBox(
      color: Colors.black.withValues(alpha: 0.8),
      child: const SizedBox.expand(
        child: Center(child: MenoLoadingIndicator.lg()),
      ),
    );
  }
}
