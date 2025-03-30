//
//ignore_for_file: strict_raw_type

import 'package:formz/formz.dart';
import 'package:meno_flutter/features/auth/auth.dart';
import 'package:meno_flutter/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_form.g.dart';

@riverpod
class RegisterForm extends _$RegisterForm {
  @override
  _FormState build() => const _FormState();

  void onFullNameChanged(String value) {
    state = state.copyWith(fullName: FullName.dirty(value));
  }

  void onEmailChanged(String value) {
    state = state.copyWith(email: EmailAddress.dirty(value));
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(
      password: Password.dirty(value, PasswordMode.register),
    );
  }

  void onTermsChanged(bool? value) {
    state = state.copyWith(terms: CheckboxField.dirty(value));
  }

  String? fullNameValidator(String? value) {
    return state.fullName.validator(value ?? '')?.text;
  }

  String? emailValidator(String? value) {
    return state.email.validator(value ?? '')?.text;
  }

  String? passwordValidator(String? value) {
    return state.password.validator(value ?? '')?.text;
  }

  String? termsValidator(bool? value) {
    return state.terms.validator(value ?? false)?.text;
  }
}

class _FormState with FormzMixin {
  const _FormState({
    this.fullName = const FullName.pure(),
    this.email = const EmailAddress.pure(),
    this.password = const Password.pure('', PasswordMode.register),
    this.terms = const CheckboxField.pure(),
  });

  final FullName fullName;
  final EmailAddress email;
  final Password password;
  final CheckboxField terms;

  _FormState copyWith({
    FullName? fullName,
    EmailAddress? email,
    Password? password,
    CheckboxField? terms,
  }) {
    return _FormState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      terms: terms ?? this.terms,
    );
  }

  @override
  List<FormzInput> get inputs => [fullName, email, password, terms];
}
