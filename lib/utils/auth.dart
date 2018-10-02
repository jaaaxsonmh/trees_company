import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
    Future<String> signInWitEmailAndPassword(String email, String password) async{
      FirebaseUser user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return user.uid;
    }
}

