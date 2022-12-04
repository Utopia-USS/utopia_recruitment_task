import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:utopia_recruitment_task/helpers/formz/email_input.dart';
import 'package:utopia_recruitment_task/helpers/formz/password_input.dart';
import 'package:utopia_recruitment_task/service/auth_service.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    this._authService,
  ) : super(const SignInState());

  final AuthService _authService;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authService.signIn(
        state.email.value,
        state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await createUser();
      } else {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: e.message,
          ),
        );
      }
    } on Exception catch (_) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> createUser() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authService.register(
        state.email.value,
        state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.message,
        ),
      );
    } on Exception catch (_) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }
}
