import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/auth/domain/domain.dart';

final class UserCredential with EquatableMixin {
  const UserCredential({required this.token, required this.user});

  final Token token;
  final User user;

  @override
  List<Object?> get props => [token, user];

  UserCredential copyWith({Token? token, User? user}) {
    return UserCredential(token: token ?? this.token, user: user ?? this.user);
  }

  @override
  String toString() {
    return 'UserCredential{token=$token, user=$user}';
  }
}

extension UserCrendentialX on UserCredential {
  UserCredential get stripped {
    return UserCredential(user: user.stripped, token: token);
  }
}
