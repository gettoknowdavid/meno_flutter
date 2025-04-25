import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/routing/routing.dart';
import 'package:meno_flutter/src/services/services.dart';

class ImageSourceModal extends StatelessWidget {
  const ImageSourceModal({super.key});

  @override
  Widget build(BuildContext context) {
    const children = MenoImageSource.values;
    return MenoModal(
      title: 'Pick image source',
      padding: EdgeInsets.zero,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: Insets.xxlg,
            children: children.map(_SourceWidget.new).toList(),
          ),
        );
      },
    );
  }
}

class _SourceWidget extends StatelessWidget {
  const _SourceWidget(this.source, {super.key});
  final MenoImageSource source;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return InkWell(
      onTap: () => context.pop(source),
      borderRadius: MenoBorderRadius.xlg,
      child: Container(
        padding: const EdgeInsets.all(Insets.xxlg),
        decoration: BoxDecoration(
          color: colors.cardPrimary,
          borderRadius: MenoBorderRadius.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: colors.labelDisabled),
            const MenoSpacer.v(Insets.md),
            MenoText.caption(source.name, color: colors.labelDisabled),
          ],
        ),
      ),
    );
  }

  IconData get icon {
    return switch (source) {
      MenoImageSource.camera => Icons.camera,
      MenoImageSource.gallery => Icons.image_sharp,
    };
  }
}

extension ImageSourceModalX on BuildContext {
  Future<MenoImageSource?> showImageSourceModal() async {
    return showModalBottomSheet<MenoImageSource?>(
      context: this,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => const ImageSourceModal(),
    );
  }
}
