import 'package:formz/formz.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_form.g.dart';

@riverpod
class LoginForm extends _$LoginForm {
  @override
  LoginFormState build() => const LoginFormState();

  void onEmailChanged(String value) {
    state = state.copyWith(email: Email.dirty(value));
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(password: Password.dirty(value));
  }

  Future<void> submit() async {
    if (Formz.validate(state.inputs)) {
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

class LoginFormState with FormzMixin {
  const LoginFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
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

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [email, password];
}
