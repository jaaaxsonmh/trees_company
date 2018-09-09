import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/widgets/introAnimation.dart';

class ToolInfo extends StatelessWidget {
  final DocumentSnapshot document;

  ToolInfo(this.document);

  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 10,
            child: PageView(children: <Widget>[
              //tree co welcome
              IntroAnimation(
                  title: document[Fire.TOOLS_TITLE],
                  src: document[Fire.TOOLS_IMAGE],
                  content: "\$" + document[Fire.TOOLS_PRICE].toString()
              )
            ]),
          ),
          Expanded(flex: 1, child: Container()),
        ],

      ),
    );
  }
}