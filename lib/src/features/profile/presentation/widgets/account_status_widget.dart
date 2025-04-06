import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class AccountStatusWidget extends StatelessWidget {
  const AccountStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return Row(
      children: [
        const MenoTag.disabled('FREE ACCOUNT'),
        const MenoSpacer.h(Insets.lg),
        InkWell(
          onTap: () {},
          child: MenoText.caption(
            'Upgrade to premium',
            color: colors.brandPrimary,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
