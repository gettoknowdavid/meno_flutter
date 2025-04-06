import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/auth/domain/domain.dart';
import 'package:meno_flutter/src/shared/shared.dart';

final class UserCredential with EquatableMixin {
  const UserCredential({required this.token, required this.user});

  factory UserCredential.empty() {
    return UserCredential(
      token: Token(''),
      user: User(
        id: Id.fromString(''),
        fullName: const FullName.pure('New Birth Group'),
        email: const Email.pure('newbirthgroup@gmail.com'),
        bio: const Bio.pure(
          '''This is a group that is committed to the growth of those that have been re-birthed in Christ. The vision of this group is to bring to light the possibilities of the New Creation in Christ via the teaching of the word, prayer-- equipping each member for the work of ministry, that each may walk worthy of the Lord in all things.''',
        ),
      ),
    );
  }

  final Token token;
  final User user;

  @override
  List<Object?> get props => [token, user];

  UserCredential copyWith({Token? token, User? user}) {
    return UserCredential(token: token ?? this.token, user: user ?? this.user);
  }

  @override
  bool get stringify => true;
}

extension UserCrendentialX on UserCredential {
  UserCredential get stripped {
    return UserCredential(user: user.stripped, token: token);
  }
}
