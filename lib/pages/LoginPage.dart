import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import 'package:trees_co/utils/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth});
  final BaseAuth auth;

  @override
  LoginPageState createState() => LoginPageState();
}

enum FormType { login, register }

class LoginPageState extends State<LoginPage> {
  // key for form to be able to validate
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSaveLogin() {
    // get forms state (the values)
    final form = formKey.currentState;

    //print to console
    if (form.validate()) {
      // if valid then save.
      form.save();
      print('valid form. Email: $_email, password: $_password');
      return true;
    }
    return false;
  }

  void validatedAndSubmit() async {
    if (validateAndSaveLogin()) {
      try {
        //login with email if type login other wise, create user.
        if (_formType == FormType.login)
          {
            FirebaseUser user = await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password);
            print('User signed in: ${user.uid}');
            MyNavigator.goToSplash(context);
          } else {
          FirebaseUser user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: _email, password: _password);
          print('User registered: ${user.uid}');
          MyNavigator.goToSplash(context);
        }
      } catch (e) {
        print('Error encounted: $e');
      }
    }
  }

  void goToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void goToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Login Here'),
          backgroundColor: Colors.green,
        ),
        body: new Container(
            padding: EdgeInsets.all(10.0),
            child: new Form(
                key: formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInputs() + buildSubmitButtons()
                ))));
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        obscureText: true,
        decoration: new InputDecoration(labelText: 'Password'),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if(_formType == FormType.login){
      return [
        new RaisedButton(
            color: Colors.green,
            child: new Text('Login',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validatedAndSubmit),
        new FlatButton(
            onPressed: goToRegister,
            child: new Text('Create an account',
                style: new TextStyle(fontSize: 20.0, color: Colors.green)))
      ];
    } else {
      return [
        new RaisedButton(
            color: Colors.green,
            child: new Text('Create an Account',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validatedAndSubmit),
        new FlatButton(
            onPressed: goToLogin,
            child: new Text('Have an account? Login',
                style: new TextStyle(fontSize: 20.0, color: Colors.green)))
      ];
    }
  }
}
