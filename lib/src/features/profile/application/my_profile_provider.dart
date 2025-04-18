import 'package:meno_flutter/src/config/session/session.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_profile_provider.g.dart';

@riverpod
class MyProfile extends _$MyProfile {
  @override
  Future<Profile> build() async {
    final id = ref.watch(sessionProvider).valueOrNull?.user.id;
    if (id == null) throw const NoPrfileFoundException();

    final result = await ref.read(profileFacadeProvider).getProfile(id);
    return result.fold((exception) => throw exception, (profile) => profile);
  }

  void optimistcallyUpdate(Profile profile) {
    final updatedProfile = state.valueOrNull?.copyWith(
      fullName: profile.fullName,
      bio: profile.bio,
      imageUrl: profile.imageUrl,
    );
    state = AsyncData(updatedProfile!);
  }
}
