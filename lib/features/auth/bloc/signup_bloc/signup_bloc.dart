import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<SignupNameChanged>(_onNameChanged);
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupPasswordVisibilityChanged>(_onPasswordVisibilityChanged);
    on<SignupCompanyNameChanged>(_onCompanyNameChanged);
    on<SignupTermsChanged>(_onTermsChanged);
    on<SignupSubmitted>(_onSubmitted);
  }

  void _onNameChanged(SignupNameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(name: event.name, status: SignupStatus.initial));
  }

  void _onEmailChanged(SignupEmailChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(email: event.email, status: SignupStatus.initial));
  }

  void _onPasswordChanged(
    SignupPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(password: event.password, status: SignupStatus.initial),
    );
  }

  void _onPasswordVisibilityChanged(
    SignupPasswordVisibilityChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onCompanyNameChanged(
    SignupCompanyNameChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        companyName: event.companyName,
        status: SignupStatus.initial,
      ),
    );
  }

  void _onTermsChanged(SignupTermsChanged event, Emitter<SignupState> emit) {
    emit(
      state.copyWith(
        termsAccepted: event.accepted,
        status: SignupStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    if (state.name.isEmpty ||
        state.email.isEmpty ||
        state.password.isEmpty ||
        state.companyName.isEmpty) {
      emit(
        state.copyWith(
          status: SignupStatus.invalid,
          errorMessage: 'All fields are required',
        ),
      );
      return;
    }

    if (!state.termsAccepted) {
      emit(
        state.copyWith(
          status: SignupStatus.invalid,
          errorMessage: 'You must accept the terms',
        ),
      );
      return;
    }

    emit(state.copyWith(status: SignupStatus.loading));

    try {
      // Mock network delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock logic: Fail if password is "error"
      if (state.password == 'error') {
        throw Exception('Signup failed');
      }

      emit(state.copyWith(status: SignupStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: SignupStatus.failure,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }
}
