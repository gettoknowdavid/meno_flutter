import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/shared/shared.dart';

export 'order_by.dart';

/// The default size for pagination responses
///
const kPageSize = 8;

final fakeBroadcasts = List.generate(2, (index) {
  return Broadcast(
    id: ID.empty,
    title: SingleLineString('Special Thanksgiving Service with Pastey'),
    description: MultiLineString(
      'How do we create systems for the word of God to thrive? ',
    ),
    creatorId: ID.empty,
    creator: Participant(
      id: ID.empty,
      fullName: SingleLineString('Celebration Church Intertional'),
    ),
    fullName: SingleLineString('Celebration Church Intertional'),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 1)),
    createdAt: DateTime.now(),
    liveListeners: 100,
    totalListeners: 200,
  );
});
