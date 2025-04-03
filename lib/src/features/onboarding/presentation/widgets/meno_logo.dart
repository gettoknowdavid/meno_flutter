import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class MenoLogo extends StatelessWidget {
  const MenoLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final brighness = Theme.of(context).brightness;
    return Center(
      child: SizedBox(
        height: 32,
        child: switch (brighness) {
          Brightness.light => MenoAssets.images.logo.menoPurple.image(),
          Brightness.dark => MenoAssets.images.logo.menoWhite.image(),
        },
      ),
    );
  }
}
