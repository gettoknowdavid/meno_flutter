import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meno_design_system/meno_design_system.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/shared/shared.dart';

class EditProfileModal extends HookConsumerWidget {
  const EditProfileModal({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);

    ref.listen(editProfileFormProvider, (previous, next) {
      switch (next.status) {
        case MenoFormStatus.canceled:
        case MenoFormStatus.inProgress:
        case MenoFormStatus.initial:
          return;
        case MenoFormStatus.failure:
          final message = next.exception!.message;
          MenoSnackBar.error(
            message,
            size: message.contains('\n') ? MenoSize.md : MenoSize.sm,
          );
        case MenoFormStatus.success:
          Navigator.pop(context);
      }
    });

    return MenoModal(
      title: 'Edit profile details',
      builder: (context) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: _ImageField(key: Key('EditProfileImageField'))),
                MenoSpacer.v(24),
                _FullNameField(key: Key('EditProfileFullNameField')),
                MenoSpacer.v(24),
                _DescriptionField(key: Key('EditProfileDescriptionField')),
                MenoSpacer.v(24),
                _SubmitButton(key: Key('EditProfileSubmitButton')),
                MenoSpacer.v(180),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FullNameField extends HookConsumerWidget {
  const _FullNameField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(editProfileFormProvider.select((s) => s.status));
    final name = ref.watch(editProfileFormProvider.select((s) => s.name));
    final controller = useTextEditingController(text: name?.getOrNull());
    final focusNode = useFocusNode();

    return MenoTextfield(
      placeholder: 'Full name',
      label: 'Full name',
      controller: controller,
      size: MenoSize.lg,
      enabled: status != MenoFormStatus.inProgress,
      focusNode: focusNode,
      onChanged: ref.read(editProfileFormProvider.notifier).onNameChanged,
      validator: (value) => name?.failureOrNull?.message,
    );
  }
}

class _DescriptionField extends HookConsumerWidget {
  const _DescriptionField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(editProfileFormProvider.select((s) => s.status));
    final bio = ref.watch(editProfileFormProvider.select((s) => s.bio));
    final controller = useTextEditingController(text: bio?.getOrNull());
    final focusNode = useFocusNode();

    return MenoTextbox(
      placeholder: 'Description',
      label: 'Description',
      controller: controller,
      size: MenoSize.lg,
      enabled: status != MenoFormStatus.inProgress,
      focusNode: focusNode,
      onChanged: ref.read(editProfileFormProvider.notifier).onBioChanged,
      validator: (value) => bio?.failureOrNull?.message,
    );
  }
}

class _ImageField extends HookConsumerWidget {
  const _ImageField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = MenoColorScheme.of(context);
    final status = ref.watch(editProfileFormProvider.select((s) => s.status));

    final url = ref.watch(
      editProfileFormProvider.select((s) => s.profile?.imageUrl),
    );

    final file = ref.watch(editProfileFormProvider.select((s) => s.image));

    Future<void> onTap() async {
      final source = await context.showImageSourceModal();
      if (source == null) return;
      await ref.read(editProfileFormProvider.notifier).imageChanged(source);
    }

    return SizedBox.square(
      dimension: 96,
      child: Stack(
        children: [
          MenoAvatar(
            url: url,
            radius: 48,
            file: file?.value.getOrElse(() => null),
            onTap: status == MenoFormStatus.inProgress ? null : onTap,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: colors.brandPrimary,
                border: Border.all(color: colors.sectionPrimary, width: 2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                MIcons.edit_02,
                size: 16,
                color: colors.buttonLabelPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(editProfileFormProvider.select((s) => s.status));

    return MenoPrimaryButton(
      size: MenoSize.lg,
      onPressed: () async {
        if (ref.read(editProfileFormProvider).hasChanges) {
          await ref.read(editProfileFormProvider.notifier).submit();
        }
      },
      isLoading: status == MenoFormStatus.inProgress,
      disabled: !ref.watch(editProfileFormProvider).hasChanges,
      child: const Text('Save changes'),
    );
  }
}
