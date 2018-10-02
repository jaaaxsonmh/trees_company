import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/pages/home/tools/ToolsDetailHeader.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/MyNavigator.dart';

class ToolInfo extends StatelessWidget {
  final DocumentSnapshot document;


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ToolInfo(this.document);

  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Product Details'),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                  new Icon(Icons.add_shopping_cart)
              )
            ],
          )
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new ToolsDetailHeader(document)
          ],
        ),
      ),
    );
  }

}
