import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/routing/router.dart';
import 'package:meno_flutter/src/services/permissions/permissions.dart';
import 'package:responsive_framework/responsive_framework.dart';

const List<Destination> _destinations = [
  Destination(icon: Icon(MIcons.home_04), label: 'Home'),
  Destination(icon: Icon(MIcons.compass), label: 'Discover'),
  Destination(icon: Icon(MIcons.file_02), label: 'Notes'),
  Destination(icon: Icon(MIcons.user), label: 'Profile'),
];

class MenoLayout extends HookConsumerWidget {
  const MenoLayout({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final micPermissions = ref.watch(microphonePermissionsProvider);

    final currentIndex = navigationShell.currentIndex;
    final useSideNavRail = ResponsiveBreakpoints.of(context).largerThan(MOBILE);

    void handleNavigation(int index) {
      if (index == currentIndex) return;

      return navigationShell.goBranch(
        index,
        initialLocation: index == currentIndex,
      );
    }

    Future<void> onMicrophoneButtonPressed() async {
      if (!context.mounted) return;

      final status = micPermissions.value ?? MenoPermissionStatus.denied;

      if (status.isGranted) {
        await const CreateBroadcastRoute().push(context);
      }

      if ((status.isPermanentlyDenied || status.isDenied) && context.mounted) {
        final res = await const PermissionsRequestRoute().push(context);
        if (res == true && context.mounted) {
          final notifier = ref.read(microphonePermissionsProvider.notifier);
          await notifier.openSettings();
        }
      }
    }

    if (useSideNavRail) {
      return Scaffold(
        body: Row(
          children: [
            // MenoNavigationRail(
            //   selectedIndex: currentIndex,
            //   onDestinationSelected: handleNavigation,
            //   destinations: _destinations, // Pass raw data
            //   onMicButtonPressed: handleMicButtonPress, // Delegate action
            // ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: MenoBottomNavigationBar(
        selectedIndex: currentIndex,
        onTap: handleNavigation,
        destinations: _destinationWidgets(
          context: context,
          ref: ref,
          currentIndex: currentIndex,
          onTap: handleNavigation,
          onMicButtonPressed: onMicrophoneButtonPressed,
        ),
      ),
    );
  }

  List<Widget> _destinationWidgets({
    required BuildContext context,
    required WidgetRef ref,
    required int currentIndex,
    required ValueChanged<int> onTap,
    required VoidCallback onMicButtonPressed,
  }) {
    final widgets = <Widget>[];

    // Calculate middle index robustly for inserting the microphone button
    final middleInsertIndex = (_destinations.length / 2).floor();

    for (var i = 0; i < _destinations.length; i++) {
      if (i == middleInsertIndex) {
        widgets.add(
          MenoMicrophoneButton(
            key: const Key('MenoLayoutMicrophoneButton'),
            onPressed: onMicButtonPressed,
          ),
        );
      }

      final destination = _destinations[i];
      widgets.add(
        NavigationCell(
          icon: destination.icon,
          label: destination.label,
          selected: currentIndex == i,
          onTap: () => onTap(i),
        ),
      );
    }

    return widgets;
  }
}
