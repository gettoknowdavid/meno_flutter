import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/features/auth/auth.dart';

class TermsOfServiceCheckbox extends HookConsumerWidget {
  const TermsOfServiceCheckbox({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final terms = ref.watch(registerFormProvider.select((s) => s.terms));
    final colors = MenoColorScheme.of(context);
    final focusNode = useFocusNode();

    return MenoCheckbox(
      value: terms.value,
      focusNode: focusNode,
      isError: terms.isNotValid,
      validator: ref.read(registerFormProvider.notifier).termsValidator,
      onChanged: ref.read(registerFormProvider.notifier).onTermsChanged,
      label: Row(
        children: [
          const MenoText.caption('By continuing you agree to our '),
          InkWell(
            onTap: () {},
            child: MenoText.micro('Terms of Service', color: colors.infoBase),
          ),
        ],
      ),
    );
  }
}
