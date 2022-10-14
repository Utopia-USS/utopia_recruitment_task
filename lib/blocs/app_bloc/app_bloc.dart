import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:utopia_recruitment_task/service/auth_service.dart';
import 'package:utopia_recruitment_task/models/firebase_user_model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthService _authenticationRepository;

  late final StreamSubscription<FirebaseUser> _userSubscription;

  AppBloc({
    required authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AppState.unauthenticated()) {
    on<AppUserChanged>(_onUserChanged);

    on<AppLogoutRequested>(_onLogoutRequested);

    _userSubscription = authenticationRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  Future<void> _onUserChanged(
      AppUserChanged event, Emitter<AppState> emit) async {
    try {
      if (event.user.isNotEmpty) {
        emit(AppState.authenticated(event.user));
      } else {
        emit(const AppState.unauthenticated());
      }
    } catch (_) {
      unawaited(_authenticationRepository.logOut());
      emit(const AppState.unauthenticated());
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
