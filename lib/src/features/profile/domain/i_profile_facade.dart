import 'package:dartz/dartz.dart';
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/shared/shared.dart';

abstract class IProfileFacade {
  /// Updates the [Profile] of the currently authenticated with the
  /// given fields:
  ///
  /// [FullName] : Full name of the user
  ///
  /// [Bio] : Biography of the user
  ///
  /// [ImageFile] : Image of the user
  ///
  Future<Either<ProfileException, Profile>> editProfile({
    required Id id,
    FullName? fullName,
    Bio? bio,
    ImageFile? image,
  });

  /// Gets the [Profile] that matches the give [id]
  ///
  Future<Either<ProfileException, Profile>> getProfile(Id id);

  Future<Either<ProfileException, PaginatedList<Profile?>>> getProfiles({
    /// Searches for users with a name that partially or fully match the
    /// keyword. Example: `John`
    ///
    String? keywords,

    /// Adds an extra field to each response indicating if the logged in
    /// user is subscribed to the user Example: `subscribed`
    ///
    /// Defaults to `subscribed`
    ///
    String include = 'subscribed',

    /// Sort by a specific user field
    /// Defaults to `fullName` of the profiles
    ///
    String sortBy = 'fullName',

    /// Order by a specific user field
    /// Examples:
    ///
    /// [OrderBy.ASC] which is the ascending order
    ///
    /// [OrderBy.DESC] which is the descending order
    ///
    OrderBy orderBy = OrderBy.ASC,

    /// Used for pagination.
    ///
    /// Defaults to `1` signifying the first page
    int page = 1,

    /// The number of items to be returned per `page`
    ///
    /// Used for pagination
    ///
    /// Defaults to `8`
    ///
    int size = kPageSize,
  });

  /// Returns a list of [Profile]s that are subscribed to your account
  ///
  Future<Either<ProfileException, PaginatedList<Profile?>>> getSubscribers({
    /// The [Profile] or [User] id of the person you are subscribed to
    ///
    required Id subscriptionId,

    /// Adds an extra field to each response indicating if the logged in
    /// user is subscribed to the user Example: `subscribed`
    ///
    /// Defaults to `subscribed`
    ///
    String include = 'subscribed',

    /// Searches for users with a name that partially or fully match the
    /// keyword. Example: `John`
    ///
    String? keywords,

    /// Used for pagination.
    ///
    /// Defaults to `1` signifying the first page
    int page = 1,

    /// The number of items to be returned per `page`
    ///
    /// Used for pagination
    ///
    /// Defaults to `8`
    ///
    int size = kPageSize,
  });

  /// Returns a list of [Profile]s your account is subscribed to
  ///
  Future<Either<ProfileException, PaginatedList<Profile?>>> getSubscriptionss({
    /// The [Profile] or [User] id of the subscriber
    ///
    required Id subscriberId,

    /// Adds an extra field to each response indicating if the logged in
    /// user is subscribed to the user Example: `subscribed`
    ///
    /// Defaults to `subscribed`
    ///
    String include = 'subscribed',

    /// Searches for users with a name that partially or fully match the
    /// keyword. Example: `John`
    ///
    String? keywords,

    /// Used for pagination.
    ///
    /// Defaults to `1` signifying the first page
    int page = 1,

    /// The number of items to be returned per `page`
    ///
    /// Used for pagination
    ///
    /// Defaults to `8`
    ///
    int size = kPageSize,
  });

  /// Subscribes to the [Profile] with the given [Id]: [id]
  ///
  Future<Either<ProfileException, Unit>> subscribe(Id id);

  /// Unsubscribes from the [Profile] with the given [Id]: [id]
  ///
  Future<Either<ProfileException, Unit>> unsubscribe(Id id);
}
