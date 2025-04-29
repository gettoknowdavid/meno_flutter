import 'package:meno_flutter/src/features/broadcast/broadcast.dart';
import 'package:meno_flutter/src/features/chat/chat.dart' show Chat, ChatSender;
import 'package:meno_flutter/src/features/profile/profile.dart';
import 'package:meno_flutter/src/shared/shared.dart';

export 'order_by.dart';

/// The default size for pagination responses
///
const kPageSize = 8;

final fakeBroadcast = Broadcast(
  id: ID.empty,
  title: SingleLineString(
    'Deeper UK: Who is Jesus, Who are you? (Grand Finale)',
  ),
  description: MultiLineString(
    '''
By the revelation of Jesus Christ, we come to an awareness of who we are. The moment Peter correctly identified Jesus, he found his own identity (Matt. 16: 13-18).''',
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

final fakeUsers = [
  Profile(
    id: ID.fromString('1c326e7f-c331-4857-8125-52b13f312df8'),
    fullName: SingleLineString("Celebration Church Int'l"),
    numberOfSubscribers: 30000,
    stats: const ProfileStats(subscribers: 30000),
  ),
  Profile(
    id: ID.fromString('148290e6-992e-42d5-8048-110e237d4a21'),
    fullName: SingleLineString('The Catalyst Community Global'),

    numberOfSubscribers: 5606,
    stats: const ProfileStats(subscribers: 5606),
  ),
  Profile(
    id: ID.fromString('486478a3-1867-4a94-b2c8-436d196d8b99'),
    fullName: SingleLineString('Circle Church Global'),

    numberOfSubscribers: 5001,
    stats: const ProfileStats(subscribers: 5001),
  ),
  Profile(
    id: ID.fromString('9d76694b-4840-46c1-86db-d226f27c7eec'),
    fullName: SingleLineString('The New Global'),
    numberOfSubscribers: 8740,
    stats: const ProfileStats(subscribers: 8740),
  ),
  Profile(
    id: ID.fromString('c572a002-eac5-43f2-bdd5-2b7b2d28c637'),
    fullName: SingleLineString('The Equipping Center Global'),
    numberOfSubscribers: 6850,
    stats: const ProfileStats(subscribers: 6850),
  ),
  Profile(
    id: ID.fromString('2dd4cd64-3e34-4062-9753-6bb9651aed52'),
    fullName: SingleLineString('theupperroomfellowship'),
    numberOfSubscribers: 4550,
    stats: const ProfileStats(subscribers: 4550),
  ),
  Profile(
    id: ID.fromString('36f4e103-c51f-4e98-ae3a-5053e70ff5b0'),
    fullName: SingleLineString('Bayo Daini'),
    numberOfSubscribers: 40001,
    stats: const ProfileStats(subscribers: 40001),
  ),
  Profile(
    id: ID.fromString('b523f625-4854-4a7b-8c5f-64c490dd15fe'),
    fullName: SingleLineString('Godson Obielum'),
    numberOfSubscribers: 2235,
    stats: const ProfileStats(subscribers: 2235),
  ),
];
final fakeParticipants = [
  Participant(
    id: ID.fromString('1c326e9f-c331-4857-8125-52b13a312df8'),
    fullName: SingleLineString('David Michael'),
    role: ParticipantRole.HOST,
  ),
  Participant(
    id: ID.fromString('36f4e103-c51f-4e98-ae3a-5053e70ff5b0'),
    fullName: SingleLineString('Bayo Daini'),
    role: ParticipantRole.COHOST,
  ),
  Participant(
    id: ID.fromString('1c326e7f-c331-4857-8125-52b13f312df8'),
    fullName: SingleLineString("Celebration Church Int'l"),
  ),
  Participant(
    id: ID.fromString('148290e6-992e-42d5-8048-110e237d4a21'),
    fullName: SingleLineString('The Catalyst Community Global'),
  ),
  Participant(
    id: ID.fromString('486478a3-1867-4a94-b2c8-436d196d8b99'),
    fullName: SingleLineString('Circle Church Global'),
  ),
  Participant(
    id: ID.fromString('9d76694b-4840-46c1-86db-d226f27c7eec'),
    fullName: SingleLineString('The New Global'),
  ),
  Participant(
    id: ID.fromString('c572a002-eac5-43f2-bdd5-2b7b2d28c637'),
    fullName: SingleLineString('The Equipping Center Global'),
  ),
  Participant(
    id: ID.fromString('2dd4cd64-3e34-4062-9753-6bb9651aed52'),
    fullName: SingleLineString('theupperroomfellowship'),
  ),
  Participant(
    id: ID.fromString('b523f625-4854-4a7b-8c5f-64c490dd15fe'),
    fullName: SingleLineString('Godson Obielum'),
  ),
];

final fakeChats = <Chat>[
  Chat(
    id: ID.fromString('341cc1f3-75ff-405f-9146-c2e3d29626ac'),
    content: MultiLineString('hellooooooooo'),
    createdAt: DateTime.now(),
    broadcastId: ID.fromString('a195065a-51c4-4431-ad2d-5fa696410bfe'),
    sender: ChatSender(
      id: ID.fromString('e286c60c-44f9-4c75-aa37-b37cacb08f0f'),
      imageUrl:
          'https://res.cloudinary.com/gson007/image/upload/v1675736736/h70lwdr2blycezkv1l9q.jpg',
      fullName: SingleLineString('Bayo Daini'),
    ),
  ),
  Chat(
    id: ID.fromString('cd5301a9-a233-43a7-a4e5-fd3158b1c94a'),
    content: MultiLineString('Testing'),
    createdAt: DateTime.now(),
    broadcastId: ID.fromString('a195065a-51c4-4431-ad2d-5fa696410bfe'),
    sender: ChatSender(
      id: ID.fromString('3e43bf4d-7ab1-4d30-92d7-02fedf2d5ed1'),
      imageUrl:
          'https://res.cloudinary.com/gson007/image/upload/v1698913558/nephz6baho5wgkg8wrz0.jpg',
      fullName: SingleLineString('David Michael III'),
    ),
  ),
  Chat(
    id: ID.fromString('79e365e1-0beb-42b3-b9b0-4ceebab77358'),
    content: MultiLineString('Can you see this???'),
    createdAt: DateTime.now(),
    broadcastId: ID.fromString('a195065a-51c4-4431-ad2d-5fa696410bfe'),
    sender: ChatSender(
      id: ID.fromString('e286c60c-44f9-4c75-aa37-b37cacb08f0f'),
      imageUrl:
          'https://res.cloudinary.com/gson007/image/upload/v1675736736/h70lwdr2blycezkv1l9q.jpg',
      fullName: SingleLineString('Bayo Daini'),
    ),
  ),
  Chat(
    id: ID.fromString('dd7142b2-3966-4108-962a-73e976caa6c7'),
    content: MultiLineString('Can you see my chats?'),
    createdAt: DateTime.now(),
    broadcastId: ID.fromString('a195065a-51c4-4431-ad2d-5fa696410bfe'),
    sender: ChatSender(
      id: ID.fromString('e286c60c-44f9-4c75-aa37-b37cacb08f0f'),
      imageUrl:
          'https://res.cloudinary.com/gson007/image/upload/v1675736736/h70lwdr2blycezkv1l9q.jpg',
      fullName: SingleLineString('Bayo Daini'),
    ),
  ),
];
