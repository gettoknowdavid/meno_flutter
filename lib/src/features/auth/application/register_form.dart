//
//ignore_for_file: strict_raw_type

import 'package:formz/formz.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_form.g.dart';

@riverpod
class RegisterForm extends _$RegisterForm {
  @override
  RegisterState build() => const RegisterState();

  void onFullNameChanged(String value) {
    state = state.copyWith(fullName: FullName.dirty(value));
  }

  void onEmailChanged(String value) {
    state = state.copyWith(email: Email.dirty(value));
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(
      password: Password.dirty(value, PasswordMode.register),
    );
  }

  void onTermsChanged(bool? value) {
    state = state.copyWith(terms: CheckboxField.dirty(value));
  }

  Future<void> submit() async {
    if (Formz.validate(state.inputs)) {
      state = state.copyWith(status: MenoFormStatus.inProgress);

      final result = await ref
          .read(authFacadeProvider)
          .register(
            fullName: state.fullName,
            email: state.email,
            password: state.password,
          );

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

class RegisterState with FormzMixin {
  const RegisterState({
    this.fullName = const FullName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure('', PasswordMode.register),
    this.terms = const CheckboxField.pure(),
    this.status = MenoFormStatus.initial,
    this.exception,
  });

  final FullName fullName;
  final Email email;
  final Password password;
  final CheckboxField terms;
  final MenoFormStatus status;
  final AuthException? exception;

  RegisterState copyWith({
    FullName? fullName,
    Email? email,
    Password? password,
    CheckboxField? terms,
    MenoFormStatus? status,
    AuthException? exception,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      terms: terms ?? this.terms,
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<FormzInput> get inputs => [fullName, email, password, terms];
}
