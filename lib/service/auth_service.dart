import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:utopia_recruitment_task/models/firebase_user_model.dart';

class AuthService {
  Stream<FirebaseUser> get user => firebase_auth.FirebaseAuth.instance
          .authStateChanges()
          .map((firebaseUser) {
        final user =
            firebaseUser == null ? FirebaseUser.empty : firebaseUser.toUser;
        return user;
      });

  Future<void> signIn(String email, String password) async {
    await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> register(String email, String password) async {
    await firebase_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() async {
    await firebase_auth.FirebaseAuth.instance.signOut();
  }
}

extension on firebase_auth.User {
  FirebaseUser get toUser => FirebaseUser(
        id: uid,
        email: email,
      );
}
