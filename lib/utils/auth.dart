import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWitEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
}

class Auth implements BaseAuth {

  // sign in
    Future<String> signInWitEmailAndPassword(String email, String password) async{
      FirebaseUser user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return user.uid;
    }

    // create user
    Future<String> createUserWithEmailAndPassword(String email, String password) async {
      FirebaseUser user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return user.uid;
    }

    // async'ly get current user or null if there is none
    Future<String> currentUser() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      return user.uid;
    }

}

