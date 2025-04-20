import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';

final _tabs = <int, MenoTab>{
  0: const MenoTab(key: Key('BroadcastTab'), text: 'Broadcast'),
  1: const MenoTab(key: Key('ChatTab'), text: 'Chat'),
  2: const MenoTab(key: Key('BibleTab'), text: 'Live Bible'),
  3: const MenoTab(key: Key('NotesTab'), text: 'Live Notes'),
};

class LiveSessionPage extends HookConsumerWidget {
  const LiveSessionPage({required this.broadcastID, super.key});
  final String broadcastID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

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
        // const LiveSessionLoadingOverlay(),
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
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: Insets.lg),
        constraints: const BoxConstraints(minHeight: 32),
        child: MenoTabBar.normal(
          controller: controller,
          onTap: onTabChanged,
          tabs: _tabs.values.map((tab) => tab).toList(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
