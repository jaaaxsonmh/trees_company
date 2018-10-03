
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Settings  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SettingsState();
  }
}

enum StateType {setProfile, showProfile}

class _SettingsState extends State<Settings> {

  final formKey = new GlobalKey<FormState>();

  String _name;
  String _location;
  String _interests;
  StateType _stateType = StateType.setProfile;



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Profile'),
            new Padding(
              padding: EdgeInsets.all(10.0),
              child:
                new Icon(Icons.settings)
            )
          ],
        )
      ),
      body: new Container(
      )
    );
  }
}