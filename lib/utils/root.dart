import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trees_co/pages/IntroScreen.dart';
import 'package:trees_co/pages/LoginPage.dart';
import 'package:trees_co/pages/SplashScreen.dart';
import 'package:trees_co/utils/LocalDB.dart';
import 'package:trees_co/utils/auth.dart';
import 'package:trees_co/pages/home/HomeScreen.dart';

class Root extends StatefulWidget {
  Root({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootState();
}

enum AuthStatus { notSignedIn, signedIn, splash, into, home }

class _RootState extends State<Root> {
  // initial not signed in
  AuthStatus _authStatus = AuthStatus.splash;

  AuthStatus _afterSplash = AuthStatus.into;
  AuthStatus _afterInto = AuthStatus.notSignedIn;

  void initState() {
    super.initState();
    // While waiting show splash
    _getCurrentInitialState();
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  void _afterSplashState() {
    setState(() {
      _authStatus = _afterSplash;
    });
  }

  void _afterIntoCards() {
    setState(() {
      _authStatus = _afterInto;
    });
  }

  _getCurrentInitialState() async {
    var userId = await widget.auth.currentUser();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var hasSeenIntoCards = prefs.getBool(LocalDB.isIntro) ?? false;


    if (userId == null) {
      _afterInto = AuthStatus.notSignedIn;
    } else {
      _afterInto = AuthStatus.home;
    }

    if (hasSeenIntoCards){
      _afterSplash = AuthStatus.home;
    }else {
      _afterSplash = AuthStatus.into;
    }

  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(auth: widget.auth, onSignedIn: _signedIn);
      case AuthStatus.signedIn:
        return new HomeScreen(auth: widget.auth, onSignedOut: _signedOut);
      case AuthStatus.into:
        return new IntroScreen(onIntoOver: _afterIntoCards);
      case AuthStatus.splash:
        return new SplashScreen(onSplashOver: _afterSplashState);
      case AuthStatus.home:
        return new HomeScreen(auth: widget.auth, onSignedOut: _signedOut);
    }
  }
}
