import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/services/services.dart';
import 'package:meno_flutter/src/shared/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_profile_form.g.dart';

@Riverpod(keepAlive: true)
class EditProfileForm extends _$EditProfileForm {
  @override
  EditProfileFormState build() {
    final profile = ref.read(myProfileProvider).valueOrNull;

    if (profile == null) {
      return const EditProfileFormState(
        exception: ProfileExceptionWithMessage('Profile not loaded'),
      );
    }

    return EditProfileFormState(
      profile: profile,
      name: FullName.dirty(profile.fullName.value),
      bio: Bio.dirty(profile.bio?.value),
    );
  }

  void onNameChanged(String value) {
    state = state.copyWith(name: FullName.dirty(value));
  }

  void onBioChanged(String value) {
    state = state.copyWith(bio: Bio.dirty(value));
  }

  Future<void> imageChanged({bool fromGallery = true}) async {
    final file = await ref
        .read(mediaPickerProvider)
        .getImage(fromGallery: fromGallery);

    if (file != null) {
      state = state.copyWith(image: ImageFile.dirty(File(file.path)));
    }
  }

  Future<void> submit() async {
    if (state.hasChanges) {
      state = state.copyWith(status: MenoFormStatus.inProgress);

      final result = await ref
          .read(profileFacadeProvider)
          .editProfile(
            id: state.profile!.id,
            fullName: state.name.isPure ? null : state.name,
            bio: state.bio.isPure ? null : state.bio,
            image: state.image.isPure ? null : state.image,
          );

      state = result.fold(
        (exception) => state.copyWith(
          status: MenoFormStatus.failure,
          exception: exception,
        ),
        (profile) {
          ref.read(myProfileProvider.notifier).optimistcallyUpdate(profile);
          return state.copyWith(status: MenoFormStatus.success);
        },
      );
    }
  }
}

class EditProfileFormState with FormzMixin, EquatableMixin {
  const EditProfileFormState({
    this.profile,
    this.name = const FullName.pure(),
    this.bio = const Bio.pure(),
    this.image = const ImageFile.pure(),
    this.status = MenoFormStatus.initial,
    this.exception,
  });

  final Profile? profile;
  final FullName name;
  final Bio bio;
  final ImageFile image;
  final MenoFormStatus status;
  final ProfileException? exception;

  EditProfileFormState copyWith({
    FullName? name,
    Bio? bio,
    ImageFile? image,
    MenoFormStatus? status,
    ProfileException? exception,
  }) {
    return EditProfileFormState(
      profile: profile,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      image: image ?? this.image,
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }

  bool get hasChanges {
    final nameHasChanges = profile?.fullName.value != name.value;
    final bioHasChanges = profile?.bio?.value != bio.value;
    final imageHasChanges = !image.isPure;
    return nameHasChanges || bioHasChanges || imageHasChanges;
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [name, bio, image];

  @override
  List<Object?> get props => [name, bio, image, status, exception];

  @override
  bool? get stringify => true;
}
