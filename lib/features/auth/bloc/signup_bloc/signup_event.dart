import 'package:equatable/equatable.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

final class SignupNameChanged extends SignupEvent {
  final String name;
  const SignupNameChanged(this.name);
  @override
  List<Object> get props => [name];
}

final class SignupEmailChanged extends SignupEvent {
  final String email;
  const SignupEmailChanged(this.email);
  @override
  List<Object> get props => [email];
}

final class SignupPasswordChanged extends SignupEvent {
  final String password;
  const SignupPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

final class SignupPasswordVisibilityChanged extends SignupEvent {
  const SignupPasswordVisibilityChanged();
}

final class SignupCompanyNameChanged extends SignupEvent {
  final String companyName;
  const SignupCompanyNameChanged(this.companyName);
  @override
  List<Object> get props => [companyName];
}

final class SignupTermsChanged extends SignupEvent {
  final bool accepted;
  const SignupTermsChanged(this.accepted);
  @override
  List<Object> get props => [accepted];
}

final class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}
