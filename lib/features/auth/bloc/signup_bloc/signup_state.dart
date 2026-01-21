import 'package:equatable/equatable.dart';

enum SignupStatus { initial, invalid, loading, success, failure }

final class SignupState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String companyName;
  final bool isPasswordVisible;
  final bool termsAccepted;
  final SignupStatus status;
  final String? errorMessage;

  const SignupState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.companyName = '',
    this.isPasswordVisible = false,
    this.termsAccepted = false,
    this.status = SignupStatus.initial,
    this.errorMessage,
  });

  SignupState copyWith({
    String? name,
    String? email,
    String? password,
    String? companyName,
    bool? isPasswordVisible,
    bool? termsAccepted,
    SignupStatus? status,
    String? errorMessage,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      companyName: companyName ?? this.companyName,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    companyName,
    isPasswordVisible,
    termsAccepted,
    status,
    errorMessage,
  ];
}
