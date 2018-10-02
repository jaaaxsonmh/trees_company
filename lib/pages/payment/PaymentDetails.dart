import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/pages/LoginPage.dart';
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
  final formKey = new GlobalKey<FormState>();

  FormType _formType = FormType.login;

  String _cardNumber;
  String _date;
  String _cvv;


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
                    padding: EdgeInsets.all(10.0),
                    child: new Icon(Icons.payment))
              ],
            )),
        body: new Container(
            padding: EdgeInsets.all(10.0),
            child: new Form(
                key: formKey,
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new TextFormField(
                        decoration:
                            new InputDecoration(labelText: 'Card number'),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value.isEmpty ? 'Email can\'t be empty' : null,
                        onSaved: (value) => _cardNumber = value,
                      ),
                      new TextFormField(
                        decoration:
                            new InputDecoration(labelText: 'Expiry date'),
                        keyboardType: TextInputType.datetime,
                        validator: (value) =>
                            value.isEmpty ? 'Email can\'t be empty' : null,
                        onSaved: (value) => _date = value,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'CVV'),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value.isEmpty ? 'Email can\'t be empty' : null,
                        onSaved: (value) => _cvv = value,
                      ),
                      new RaisedButton(
                          onPressed: () {},
                          child: new Text(
                            "Save",
                            style: new TextStyle(color: Colors.white),
                          ),
                          color: Colors.green)
                    ]))));
  }
}
