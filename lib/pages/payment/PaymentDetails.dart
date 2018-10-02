import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:date_format/date_format.dart';

class PaymentDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PaymentDetails();
  }
}

class _PaymentDetails extends State<PaymentDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Payment'),
              new Padding(
                  padding: EdgeInsets.all(10.0), child: new Icon(Icons.payment))
            ],
          )),
    );
  }
}
