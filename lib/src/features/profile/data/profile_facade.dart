import 'package:dartz/dartz.dart';
import 'package:meno_flutter/src/config/constants/constants.dart'
    show kPageSize;
import 'package:meno_flutter/src/config/constants/order_by.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/shared/domain/value_objects/bio.dart';
import 'package:meno_flutter/src/shared/domain/value_objects/full_name.dart';
import 'package:meno_flutter/src/shared/domain/value_objects/id.dart';
import 'package:meno_flutter/src/shared/domain/value_objects/image_file.dart';

class ProfileFacade implements IProfileFacade {
  @override
  Future<Either<ProfileException, Profile>> editProfile({
    FullName? fullName,
    Bio? bio,
    ImageFile? image,
  }) async {
    // TODO: implement editProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<ProfileException, Profile>> getProfile(Id id) async {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<ProfileException, List<Profile?>>> getProfiles({
    String? keywords,
    String include = 'subscribed',
    String sortBy = 'fullName',
    OrderBy orderBy = OrderBy.ASC,
    int page = 1,
    int size = kPageSize,
  }) async {
    // TODO: implement getProfiles
    throw UnimplementedError();
  }

  @override
  Future<Either<ProfileException, List<Profile?>>> getSubscribers({
    required Id subscriptionId,
    String include = 'subscribed',
    String? keywords,
    int page = 1,
    int size = kPageSize,
  }) async {
    // TODO: implement getSubscribers
    throw UnimplementedError();
  }

  @override
  Future<Either<ProfileException, List<Profile?>>> getSubscriptionss({
    required Id subscriberId,
    String include = 'subscribed',
    String? keywords,
    int page = 1,
    int size = kPageSize,
  }) async {
    // TODO: implement getSubscriptionss
    throw UnimplementedError();
  }

  @override
  Future<Either<ProfileException, Unit>> subscribe(Id id) async {
    // TODO: implement subscribe
    throw UnimplementedError();
  }

  @override
  Future<Either<ProfileException, Unit>> unsubscribe(Id id) async {
    // TODO: implement unsubscribe
    throw UnimplementedError();
  }
}
