import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
    void signInWitEmailAndPassword(String email, String password) async{
      FirebaseUser user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    }
}

