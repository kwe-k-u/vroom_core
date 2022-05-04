


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier{

  FirebaseAuth? auth;

  Future<void> signIn({required String email, required String password}) async {
    auth!.signInWithEmailAndPassword(email: email, password: password).then((value) {
      if (value.user != null){
        // if (!value.user!.emailVerified){
        //   value.user!.sendEmailVerification();
        //   auth!.signOut();
        // }
      }
    });
  }

  setAuth (FirebaseAuth a) => auth = a;

  Future<void> signup({
    required String email,
    required String name,
    required String password
  }) async {

    await auth!.createUserWithEmailAndPassword(email: email, password: password).then((value)async {
      User? user = value.user;
      if (user!= null){
        await Future.wait([
        user.sendEmailVerification(),
        user.updateDisplayName(name)]
        );
      }
      await auth!.signOut();
    });
}

}