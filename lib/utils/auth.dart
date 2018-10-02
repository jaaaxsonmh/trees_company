import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWitEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // sign in
    Future<String> signInWitEmailAndPassword(String email, String password) async{
      FirebaseUser user = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return user.uid;
    }

    // create user
    Future<String> createUserWithEmailAndPassword(String email, String password) async {
      FirebaseUser user = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return user.uid;
    }

    // async'ly get current user or null if there is none
    Future<String> currentUser() async {
      FirebaseUser user = await firebaseAuth.currentUser();
      return user.uid;
    }

    Future<void> signOut() async {
      await firebaseAuth.signOut();
    }

}

