import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/routing/routing.dart';

final _tabs = <int, MenoTab>{
  0: const MenoTab(key: Key('BroadcastTab'), text: 'Broadcast'),
  1: const MenoTab(key: Key('ChatTab'), text: 'Chat'),
  2: const MenoTab(key: Key('BibleTab'), text: 'Live Bible'),
  3: const MenoTab(key: Key('NotesTab'), text: 'Live Notes'),
};

class LiveSessionLayout extends HookWidget {
  const LiveSessionLayout({
    required this.navigationShell,
    required this.children,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('LiveSessionLayout'));

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final controller = useTabController(
      initialLength: children.length,
      initialIndex: navigationShell.currentIndex,
      keys: _tabs.keys.map((key) => _tabs[key]!.key).toList(),
    );

    void handleNavigation(int index) {
      navigationShell.goBranch(index);
      FocusScope.of(context).unfocus();
    }

    // Effect to synchronize TabController FROM NavigationShell changes
    useEffect(() {
      // Only update the controller's index if it's different from the shell's
      // index.
      if (navigationShell.currentIndex != controller.index) {
        controller.animateTo(navigationShell.currentIndex);
      }
      // This effect should re-run if the shell's index changes or the
      // controller instance changes.
      return null;
    }, [navigationShell.currentIndex, controller]);

    useEffect(() {
      // Define the listener function locally
      void syncNavigationShellOnTabChange() {
        // Only update the navigation shell if the controller's index differs
        // (prevents loops if the change originated from the shell).
        if (controller.index != navigationShell.currentIndex) {
          handleNavigation(controller.index);
        }
      }

      // Add the listener
      controller.addListener(syncNavigationShellOnTabChange);

      // Return the cleanup function to remove the listener
      return () => controller.removeListener(syncNavigationShellOnTabChange);
    }, [controller, navigationShell]);

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
            children: children,
            onPageChanged: (_) => FocusScope.of(context).unfocus(),
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
