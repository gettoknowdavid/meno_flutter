//
// ignore_for_file: strict_raw_type

import 'package:formz/formz.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_form.g.dart';

@riverpod
class LoginForm extends _$LoginForm {
  @override
  _FormState build() => const _FormState();

  void onEmailChanged(String value) {
    state = state.copyWith(email: EmailAddress.dirty(value));
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(password: Password.dirty(value));
  }

  String? emailValidator(String? value) {
    return state.email.validator(value ?? '')?.text;
  }

  String? passwordValidator(String? value) {
    return state.password.validator(value ?? '')?.text;
  }
}

class _FormState with FormzMixin {
  const _FormState({
    this.email = const EmailAddress.pure(),
    this.password = const Password.pure(),
  });

  final EmailAddress email;
  final Password password;

  _FormState copyWith({EmailAddress? email, Password? password}) {
    return _FormState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<FormzInput> get inputs => [email, password];
}
