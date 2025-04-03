import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:responsive_framework/responsive_framework.dart';

const List<Destination> _destinations = [
  Destination(icon: Icon(MIcons.home_04), label: 'Home'),
  Destination(icon: Icon(MIcons.compass), label: 'Discover'),
  Destination(icon: Icon(MIcons.file_02), label: 'Notes'),
  Destination(icon: Icon(MIcons.user), label: 'Profile'),
];

class MenoLayout extends HookWidget {
  const MenoLayout({
    required this.navigationShell,
    required this.currentRoute,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('MenoLayout'));

  final StatefulNavigationShell navigationShell;
  final String? currentRoute;

  @override
  Widget build(BuildContext context) {
    final index = navigationShell.currentIndex;
    final useSideNavRail = ResponsiveBreakpoints.of(context).largerThan(MOBILE);

    Widget? sideNavRail = const SizedBox();
    Widget? bottomNavBar = MenoBottomNavigationBar(
      selectedIndex: index,
      onTap: onTap,
      destinations: destinationWidgets(context),
    );

    if (useSideNavRail) {
      bottomNavBar = null;
      sideNavRail = Container();
    }

    return Scaffold(
      body: Row(children: [sideNavRail, Expanded(child: navigationShell)]),
      bottomNavigationBar: bottomNavBar,
    );
  }

  void onTap(int index) {
    return navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  List<Widget> destinationWidgets(BuildContext context) {
    final widgets = <Widget>[];
    final itemCount = _destinations.length;

    for (var i = 0; i < itemCount; i++) {
      if (i == 2) {
        widgets.add(MenoMicrophoneButton(onPressed: () {}));
      }

      widgets.add(
        NavigationCell(
          icon: _destinations[i].icon,
          label: _destinations[i].label,
          selected: navigationShell.currentIndex == i,
          onTap: () => onTap.call(i),
        ),
      );
    }

    return widgets;
  }
}
