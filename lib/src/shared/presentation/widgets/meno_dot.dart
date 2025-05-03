import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class MenoDot extends StatelessWidget {
  const MenoDot({this.dimension = 2, super.key});
  final double dimension;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dimension,
      width: dimension,
      decoration: BoxDecoration(
        color: MenoColorScheme.of(context).labelDisabled,
        shape: BoxShape.circle,
      ),
    );
  }
}
