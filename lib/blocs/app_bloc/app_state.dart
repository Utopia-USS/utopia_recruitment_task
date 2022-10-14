part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  final AppStatus status;
  final FirebaseUser user;

  const AppState._({
    required this.status,
    this.user = FirebaseUser.empty,
  });

  const AppState.authenticated(FirebaseUser user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
        );

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
