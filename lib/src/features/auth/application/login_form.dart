//
// ignore_for_file: avoid_redundant_argument_values

import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_form.g.dart';

@riverpod
class LoginForm extends _$LoginForm {
  @override
  LoginFormState build() => const LoginFormState();

  void onEmailChanged(String value) {
    state = state.copyWith(
      email: Email(value),
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(
      password: Password(value),
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  Future<void> submit() async {
    if (state.isFormValid) {
      state = state.copyWith(status: MenoFormStatus.inProgress);

      final result = await ref
          .read(authFacadeProvider)
          .login(email: state.email, password: state.password);

      state = result.fold(
        (exception) => state.copyWith(
          status: MenoFormStatus.failure,
          exception: exception,
        ),
        (success) => state.copyWith(status: MenoFormStatus.success),
      );
    }
  }
}

class LoginFormState with EquatableMixin {
  const LoginFormState({
    this.email = Email.empty,
    this.password = Password.emptySignIn,
    this.status = MenoFormStatus.initial,
    this.exception,
  });

  final Email email;
  final Password password;
  final MenoFormStatus status;
  final AuthException? exception;

  LoginFormState copyWith({
    Email? email,
    Password? password,
    MenoFormStatus? status,
    AuthException? exception,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }

  bool get isFormValid => email.isValid && password.isValid;

  @override
  List<Object?> get props => [email, password, status, exception];

  @override
  bool? get stringify => true;
}
