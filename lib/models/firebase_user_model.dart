import 'package:equatable/equatable.dart';

/// [FirebaseUser.empty] represents an unauthenticated user.
class FirebaseUser extends Equatable {
  const FirebaseUser({
    required this.id,
    this.email,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// Empty user which represents an unauthenticated user.
  static const empty = FirebaseUser(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == FirebaseUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != FirebaseUser.empty;

  @override
  List<Object?> get props => [email, id];
}
