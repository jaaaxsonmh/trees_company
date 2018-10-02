import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/pages/LoginPage.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class PaymentDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PaymentDetails();
  }
}

class _PaymentDetails extends State<PaymentDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  var controllerCard = new MaskedTextController(mask: '0000 0000 0000 0000');
  var controllerDate = new MaskedTextController(mask: '00/00');
  var controllerCvv = new MaskedTextController(mask: '000');

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
                child: new Column(children: <Widget>[
                  new TextFormField(
                    controller: controllerCard,
                    decoration: new InputDecoration(labelText: 'Card number'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value.isEmpty ? 'Card number can\'t be empty' : null,
                    onSaved: (value) => _cardNumber = value,
                  ),
                  Row(
                    children: <Widget>[
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                          child: new TextFormField(
                            controller: controllerDate,
                            decoration: new InputDecoration(labelText: 'Expiry date'),
                            keyboardType: TextInputType.datetime,
                            validator: (value) =>
                                value.isEmpty ? 'Expiry date can\'t be empty' : null,
                            onSaved: (value) => _date = value,
                          ),
                        ),
                      ),
                      new Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                          child: new TextFormField(
                            controller: controllerCvv,
                            decoration: new InputDecoration(labelText: 'CVV'),
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                            value.isEmpty ? 'CVV can\'t be empty' : null,
                            onSaved: (value) => _cvv = value,
                          ),
                        ),
                      ),
                    ],
                  ),

                  new RaisedButton(
                      onPressed: savePaymentsDetails,
                      child: new Text(
                        "Save",
                        style: new TextStyle(color: Colors.white),
                      ),
                      color: Colors.green)
                ]))));
  }

  savePaymentsDetails() {
    final form = formKey.currentState;

    //print to console
    if (form.validate()) {
      // if valid then save.
      form.save();
      print('Valid payment details. cardNumber: $_cardNumber, exp date: $_date , cvv: $_cvv');

    }

  }
}
