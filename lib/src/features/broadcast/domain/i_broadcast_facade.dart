import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:meno_flutter/src/config/config.dart';
import 'package:meno_flutter/src/features/broadcast/domain/domain.dart';
import 'package:meno_flutter/src/shared/domain/value_objects/value_objects.dart';

abstract class IBroadcastFacade {
  Future<Either<BroadcastException, Broadcast>> createBroadcast({
    required SingleLineString title,
    required MultiLineString description,
    ImageFile? image,
    String? timezone,
    List<ID>? cohosts,
  });

  Future<Either<BroadcastException, Unit>> deleteBroadcast(ID id);

  Future<Either<BroadcastException, Broadcast>> editBroadcast({
    required ID id,
    SingleLineString? title,
    MultiLineString? description,
    ImageFile? image,
    String? timezone,
    DateTime? startTime,
  });

  Future<Either<BroadcastException, PaginatedList<Broadcast?>>> getBroadcasts({
    /// Status of the broadcast
    /// Example : active or inactive
    String? status,

    /// Adds an extra field to each broadcast response with the number of
    /// listeners that tuned in
    /// Example : totalListeners
    String? include,

    /// Returns only broadcasts of accounts the logged In user is subscribed to
    bool? onlySubscriptions,

    /// Searches for broadcasts and creators that match that keyword
    String? keywords,

    /// Return only broadcasts created by a specific user
    ID? creatorId,

    /// Sort by a specific broadcast field
    String sortBy = 'startTime',

    /// Order by a specific broadcast field
    /// Example : ASC or DESC
    OrderBy orderBy = OrderBy.ASC,

    /// Used for pagination
    int page = 1,

    /// Used for pagination
    int size = 8,

    /// Greater than end time
    String? endTimeGT,

    /// Less than end time
    String? endTimeLT,

    /// Equal to end time
    bool? endTimeExist,

    /// Greater than start time
    String? startTimeGT,

    /// Less than start time
    String? startTimeLT,

    /// Equal to start time
    bool? startTimeExist,
  });

  Future<Either<BroadcastException, Broadcast>> joinBroadcast(ID id);

  Future<Either<BroadcastException, List<Participant?>>> liveParticipants(
    ID id,
  );

  Future<Either<BroadcastException, List<Participant?>>> participants(ID id);

  Future<Either<BroadcastException, Broadcast>> startBroadcast(ID id);
}
