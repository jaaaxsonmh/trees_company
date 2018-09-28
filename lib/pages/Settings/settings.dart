import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Settings  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SettingsState();
  }
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Settings'),
            new Padding(
              padding: EdgeInsets.all(10.0),
              child:
                new Icon(Icons.settings)
            )
          ],
        )
      ),

    );
  }
}