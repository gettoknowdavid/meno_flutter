import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class ModalPage<T> extends Page<void> {
  const ModalPage({
    required this.builder,
    super.key,
    this.constraints,
    this.isScrollControlled = true,
    this.useRootNavigator = true,
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

class DialogPage<T> extends Page<T> {
  const DialogPage({
    required this.title,
    required this.description,
    this.icon,
    this.primaryActionText = 'Okay',
    this.onPrimaryAction,
    this.secondaryActionText = 'Cancel',
    this.onSecondaryAction,
    this.content,
    super.key,
    this.isDismissible = true,
    this.isDanger = false,
  });

  final bool isDismissible;

  final Widget? icon;

  final String title;

  final String description;

  final String primaryActionText;

  final VoidCallback? onPrimaryAction;

  final String secondaryActionText;

  final VoidCallback? onSecondaryAction;

  final Widget? content;

  final bool isDanger;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      settings: this,
      useSafeArea: false,
      barrierDismissible: isDismissible,
      builder: (context) {
        return MenoDialog(
          icon: icon,
          title: title,
          description: description,
          content: content,
          primaryActionText: primaryActionText,
          onPrimaryAction: onPrimaryAction,
          secondaryActionText: secondaryActionText,
          onSecondaryAction: onSecondaryAction,
          isDanger: isDanger,
        );
      },
    );
  }
}
