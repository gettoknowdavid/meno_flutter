import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';

class ProfileErrorWidget extends StatelessWidget {
  const ProfileErrorWidget({required this.error, super.key});
  final Object error;

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MIcons.info_circle, color: colors.errorBase, size: 24),
              MenoText.heading3('Error', color: colors.errorBase),
              const MenoSpacer.v(12),
              if (error is ProfileException)
                MenoText.body(
                  (error as ProfileException).message,
                  textAlign: TextAlign.center,
                )
              else
                MenoText.body(error.toString(), textAlign: TextAlign.center),
              const MenoSpacer.v(12),
              MenoSecondaryButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Reload'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
