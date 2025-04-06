import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class ModalPage<T> extends Page<void> {
  const ModalPage({
    required this.builder,
    super.key,
    this.constraints,
    this.isScrollControlled = false,
    this.useRootNavigator = false,
    this.isDismissible = true,
    this.enableDrag = true,
  });

  final WidgetBuilder builder;
  final BoxConstraints? constraints;
  final bool isScrollControlled;
  final bool useRootNavigator;
  final bool isDismissible;
  final bool enableDrag;

  @override
  Route<T> createRoute(BuildContext context) {
    return ModalBottomSheetRoute<T>(
      builder: builder,
      constraints: constraints,
      backgroundColor: MenoColorScheme.of(context).sectionPrimary,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: true,
      useSafeArea: true,
      settings: this,
    );
  }
}

class DialogPage<T> extends Page<void> {
  const DialogPage({
    required this.builder,
    super.key,
    this.barrierDismissible = true,
    this.barrierColor,
  });

  final WidgetBuilder builder;
  final bool barrierDismissible;
  final Color? barrierColor;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      builder: builder,
      settings: this,
      useSafeArea: false,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
    );
  }
}
