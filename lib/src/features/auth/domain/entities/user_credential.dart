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
        fullName: const FullName.pure(),
        email: const Email.pure(),
        bio: const Bio.pure(),
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
