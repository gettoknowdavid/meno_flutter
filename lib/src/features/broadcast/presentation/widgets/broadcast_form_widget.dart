import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/routing/router.dart';
import 'package:meno_flutter/src/shared/presentation/presentation.dart';
import 'package:meno_flutter/src/shared/shared.dart' show MenoFormStatus;

final _formKey = GlobalKey<FormState>();

class BroadcastFormWidget extends HookConsumerWidget {
  const BroadcastFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<BroadcastFormState>(broadcastFormProvider, (previous, next) {
      switch (next.status) {
        case MenoFormStatus.canceled:
        case MenoFormStatus.inProgress:
        case MenoFormStatus.initial:
          return;
        case MenoFormStatus.success:
          final broadcastID = next.broadcast!.id;
          ref.read(broadcastIDProvider.notifier).state = broadcastID;
          ref.read(liveBroadcastProvider.notifier).initialize();
          LiveSessionRoute(broadcastID.getOrCrash()).push(context);
        case MenoFormStatus.failure:
          final message = next.exception!.message;
          MenoSnackBar.error(
            message,
            size: message.contains('\n') ? MenoSize.md : MenoSize.sm,
          );
      }
    });

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ArtworkField(key: Key('BroadcastFormArtworkField')),
          MenoSpacer.v(Insets.lg),
          _TitleField(key: Key('BroadcastFormTitleField')),
          MenoSpacer.v(Insets.xlg),
          _DescriptionField(key: Key('BroadcastFormDescriptionField')),
          MenoSpacer.v(Insets.xlg),
          _CohostsSelector(key: Key('BroadcastFormCohostsField')),
          MenoSpacer.v(Insets.xlg),
          _RemainingBroadcastDuration(key: Key('BroadcastFormDurationField')),
          MenoSpacer.v(Insets.xlg),
          _EnableRecordingSwitch(key: Key('BroadcastFormRecordingField')),
          MenoSpacer.v(Insets.xlg),
        ],
      ),
    );
  }
}

class _ArtworkField extends HookConsumerWidget {
  const _ArtworkField({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    final notifier = ref.read(broadcastFormProvider.notifier);
    final file = ref.watch(broadcastFormProvider.select((s) => s.image));
    final status = ref.watch(broadcastFormProvider.select((s) => s.status));

    return Center(
      child: SizedBox(
        width: 167,
        child: Column(
          children: [
            MenoAvatar(radius: 48, file: file?.getOrNull()),
            MenoTertiaryButton(
              disabled: status == MenoFormStatus.inProgress,
              onPressed: () async {
                final source = await context.showImageSourceModal();
                if (source == null) return;
                await notifier.imageChanged(source);
              },
              child: const Text('Choose an artwork'),
            ),
            MenoText.micro(
              'JPG or PNG accepted. Max size 10mb.',
              color: colors.labelHelp,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleField extends HookConsumerWidget {
  const _TitleField({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(broadcastFormProvider.notifier);
    final title = ref.watch(broadcastFormProvider.select((s) => s.title));
    final status = ref.watch(broadcastFormProvider.select((s) => s.status));
    final focusNode = useFocusNode();
    return MenoTextfield(
      placeholder: "Jim Halpert's live audio",
      label: 'Broadcast title',
      size: MenoSize.lg,
      enabled: status != MenoFormStatus.inProgress,
      focusNode: focusNode,
      onChanged: notifier.titleChanged,
      validator: (value) => title.failureOrNull?.message,
    );
  }
}

class _DescriptionField extends HookConsumerWidget {
  const _DescriptionField({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(broadcastFormProvider.notifier);
    final desc = ref.watch(broadcastFormProvider.select((s) => s.description));
    final status = ref.watch(broadcastFormProvider.select((s) => s.status));
    final focusNode = useFocusNode();
    return MenoTextbox(
      placeholder: 'Enter a brief description',
      label: 'About broadcast',
      size: MenoSize.lg,
      enabled: status != MenoFormStatus.inProgress,
      focusNode: focusNode,
      onChanged: notifier.descriptionChanged,
      validator: (value) => desc.failureOrNull?.message,
    );
  }
}

class _CohostsSelector extends HookConsumerWidget {
  const _CohostsSelector({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(broadcastFormProvider.notifier);
    final cohosts = ref.watch(broadcastFormProvider.select((s) => s.cohosts));
    final cohostsList = cohosts.toList();
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          const Center(child: CohostWidget(user: null)),
          Expanded(
            child: LimitedBox(
              maxHeight: 72,
              child: ListView.separated(
                itemCount: cohosts.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                primary: false,
                separatorBuilder: (_, i) => const MenoSpacer.h(Insets.lg),
                itemBuilder: (context, index) {
                  final user = cohostsList[index];
                  return CohostWidget(
                    user: user,
                    onRemove: (v) => notifier.onRemoveCohost([v ?? user]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RemainingBroadcastDuration extends StatelessWidget {
  const _RemainingBroadcastDuration({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = MenoColorScheme.of(context);
    return BroadcastFormFieldItem(
      title: 'Remaining time today',
      description: 'Your daily broadcast time will reset in 24hrs',
      trailing: MenoText.caption(
        '0hr 30min',
        color: colors.labelDisabled,
        weight: MenoFontWeight.regular,
      ),
    );
  }
}

class _EnableRecordingSwitch extends HookConsumerWidget {
  const _EnableRecordingSwitch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(broadcastFormProvider.notifier);
    final recordingEnabled = ref.watch(
      broadcastFormProvider.select((s) => s.shouldRecord),
    );
    final focusNode = useFocusNode();

    return BroadcastFormFieldItem(
      title: 'Enable recording',
      description: 'Record your broadcast to listen back to later',
      trailing: Switch(
        value: recordingEnabled,
        onChanged: notifier.onShouldRecordChanged,
        focusNode: focusNode,
      ),
    );
  }
}

class BroadcastFormSubmitButton extends HookConsumerWidget {
  const BroadcastFormSubmitButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(broadcastFormProvider.select((s) => s.status));
    final notifier = ref.read(broadcastFormProvider.notifier);
    return SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.only(
          left: Insets.sm,
          right: Insets.sm,
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: MenoPrimaryButton(
          size: MenoSize.lg,
          isLoading: status == MenoFormStatus.inProgress,
          disabled: !ref.watch(broadcastFormProvider).isValid,
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              await notifier.submit();
            }
          },
          child: const Text('Start broadcast'),
        ),
      ),
    );
  }
}
