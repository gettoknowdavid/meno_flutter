//
// ignore_for_file: avoid_redundant_argument_values

import 'dart:io';

import 'package:equatable/equatable.dart';
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
      name: profile.fullName,
      bio: profile.bio,
    );
  }

  void onNameChanged(String value) {
    state = state.copyWith(
      name: SingleLineString(value),
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  void onBioChanged(String value) {
    state = state.copyWith(
      bio: MultiLineString(value),
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  Future<void> imageChanged({bool fromGallery = true}) async {
    final file = await ref
        .read(mediaPickerProvider)
        .getImage(fromGallery: fromGallery);

    if (file != null) {
      state = state.copyWith(
        image: ImageFile(File(file.path)),
        exception: null,
        status: MenoFormStatus.initial,
      );
    }
  }

  Future<void> submit() async {
    if (state.hasChanges) {
      state = state.copyWith(status: MenoFormStatus.inProgress);

      final result = await ref
          .read(profileFacadeProvider)
          .editProfile(
            id: state.profile!.id,
            fullName: state.name == state.profile?.fullName ? null : state.name,
            bio: state.bio == state.profile?.bio ? null : state.bio,
            image: state.image ?? state.image,
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

class EditProfileFormState with EquatableMixin {
  const EditProfileFormState({
    this.name,
    this.bio,
    this.image,
    this.status = MenoFormStatus.initial,
    this.profile,
    this.exception,
  });

  final Profile? profile;
  final SingleLineString? name;
  final MultiLineString? bio;
  final ImageFile? image;
  final MenoFormStatus status;
  final ProfileException? exception;

  EditProfileFormState copyWith({
    SingleLineString? name,
    MultiLineString? bio,
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
    final nameHasChanges = profile?.fullName != name;
    final bioHasChanges = profile?.bio != bio;
    final imageHasChanges = image != null;
    return nameHasChanges || bioHasChanges || imageHasChanges;
  }

  @override
  List<Object?> get props => [profile, name, bio, image, status, exception];

  @override
  bool? get stringify => true;
}
