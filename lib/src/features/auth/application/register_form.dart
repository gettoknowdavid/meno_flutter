//
// ignore_for_file: strict_raw_type
// ignore_for_file: avoid_redundant_argument_values

import 'package:equatable/equatable.dart';
import 'package:meno_flutter/src/features/auth/auth.dart';
import 'package:meno_flutter/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_form.g.dart';

@riverpod
class RegisterForm extends _$RegisterForm {
  @override
  RegisterFormState build() => const RegisterFormState();

  void onFullNameChanged(String value) {
    state = state.copyWith(
      fullName: SingleLineString(value),
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  void onEmailChanged(String value) {
    state = state.copyWith(
      email: Email(value),
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(
      password: Password(value, PasswordMode.signUp),
      passwordRules: _errors(value),
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  void onTermsChanged(bool? value) {
    state = state.copyWith(
      terms: TermsCheckbox(value ?? false),
      exception: null,
      status: MenoFormStatus.initial,
    );
  }

  Future<void> submit() async {
    if (state.isFormValid) {
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

  /// Calculates the set of all validation rule violations (for UI tracker).
  /// This getter checks against the registration rules based on the original
  /// input, regardless of the current `mode` or `isValid` state, as the
  /// UI tracker usually displays all complexity requirements.
  Set<ValueException<String>> _errors(String input) {
    final e = <ValueException<String>>{};

    if (input.length < 8) {
      e.add(const PasswordTooShort());
    }
    if (!RegExp(r'[A-Z]').hasMatch(input)) {
      e.add(const PasswordMissingUppercase());
    }
    if (!RegExp(r'[a-z]').hasMatch(input)) {
      e.add(const PasswordMissingLowercase());
    }
    if (!RegExp(r'[0-9]').hasMatch(input)) {
      e.add(const PasswordMissingNumber());
    }
    if (!RegExp(r'[@$!%*?&]').hasMatch(input)) {
      e.add(const PasswordMissingSpecialCharacter());
    }
    return e;
  }
}

class RegisterFormState with EquatableMixin {
  const RegisterFormState({
    this.fullName = SingleLineString.empty,
    this.email = Email.empty,
    this.password = Password.emptySignUp,
    this.passwordRules,
    this.terms = TermsCheckbox.emptyAsFalse,
    this.status = MenoFormStatus.initial,
    this.exception,
  });

  final SingleLineString fullName;
  final Email email;
  final Password password;
  final Set<ValueException<String>>? passwordRules;
  final TermsCheckbox terms;
  final MenoFormStatus status;
  final AuthException? exception;

  RegisterFormState copyWith({
    SingleLineString? fullName,
    Email? email,
    Password? password,
    Set<ValueException<String>>? passwordRules,
    TermsCheckbox? terms,
    MenoFormStatus? status,
    AuthException? exception,
  }) {
    return RegisterFormState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordRules: passwordRules ?? this.passwordRules,
      terms: terms ?? this.terms,
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }

  bool get isFormValid {
    return fullName.isValid &&
        email.isValid &&
        password.isValid &&
        terms.isValid;
  }

  @override
  List<Object?> get props => [
    fullName,
    email,
    password,
    terms,
    status,
    exception,
  ];
}
