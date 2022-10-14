import 'dart:async';

import 'package:utopia_recruitment_task/models/firebase_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthService {
  Stream<FirebaseUser> get user {
    return firebase_auth.FirebaseAuth.instance
        .authStateChanges()
        .map((firebaseUser) {
      final user =
          firebaseUser == null ? FirebaseUser.empty : firebaseUser.toUser;
      return user;
    });
  }

  Future signIn(String email, String password) async {
    await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future register(String email, String password) async {
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
  FirebaseUser get toUser {
    return FirebaseUser(
      id: uid,
      email: email,
    );
  }
}
