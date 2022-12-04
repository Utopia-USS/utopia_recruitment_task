part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = FirebaseUser.empty,
  });

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.authenticated(FirebaseUser user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
        );

  final AppStatus status;
  final FirebaseUser user;

  @override
  List<Object> get props => [status, user];
}
