import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/shared/domain/domain.dart' show ID;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_notifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<Profile> build(ID id) async {
    final result = await ref.read(profileFacadeProvider).getProfile(id);
    return result.fold((exception) => throw exception, (profile) => profile);
  }
}
