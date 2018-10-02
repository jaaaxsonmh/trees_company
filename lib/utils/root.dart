import 'package:flutter/material.dart';
import 'package:trees_co/pages/LoginPage.dart';
import 'package:trees_co/utils/auth.dart';

class Root extends StatefulWidget {
  Root({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootState extends State<Root> {

  // initial not signed in
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(auth: widget.auth);
      case AuthStatus.signedIn:
        return new Container(
          child: new Text('signed in test')
        );
    }
  }
}