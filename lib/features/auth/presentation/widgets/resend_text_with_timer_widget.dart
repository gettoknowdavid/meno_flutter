import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';

class ResendTextWithTimerWidget extends StatelessWidget {
  const ResendTextWithTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = MenoTextTheme.of(context);
    final colors = MenoColorScheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            style: textTheme.captionMedium.copyWith(
              color: colors.labelPlaceholder,
            ),
            children: [
              // const TextSpan(text: 'Didn\'t receive code? '),
              const TextSpan(text: 'Resend code in '),
              TextSpan(text: ' 00:59', style: textTheme.captionBold),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const MenoSpacer.h(4),
        // SizedBox(
        //   height: 18,
        //   child: MenoTertiaryButton(
        //     onPressed: () {},
        //     style: ButtonStyle(padding: Internal.all(EdgeInsets.zero)),
        //     child: const MenoText.caption('Resend'),
        //   ),
        // ),
      ],
    );
  }
}
