import 'package:flutter/material.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart'
    show BroadcastFormSubmitButton, BroadcastFormWidget;

class CreateBroadcastPage extends StatelessWidget {
  const CreateBroadcastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenoHeader.secondary(
        title: const Text('Go live now'),
        actions: const [_CancelActionButton()],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(Insets.lg),
        child: BroadcastFormWidget(),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: const [BroadcastFormSubmitButton()],
    );
  }
}

class _CancelActionButton extends StatelessWidget {
  const _CancelActionButton();

  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return MenoTertiaryButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: colors.labelHelp,
      ),
      onPressed: Navigator.of(context).pop,
      child: const Text('Cancel'),
    );
  }
}
