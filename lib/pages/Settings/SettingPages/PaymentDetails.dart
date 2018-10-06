import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:trees_co/utils/LocalDB.dart';

class PaymentDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    var pd = new _PaymentDetails();
    pd.getSavedPaymentMethod();

    return pd;
  }
}

class _PaymentDetails extends State<PaymentDetails> {
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  var controllerName = new TextEditingController();
  var controllerCard = new MaskedTextController(mask: '0000 0000 0000 0000');
  var controllerDate = new MaskedTextController(mask: '00/00');
  var controllerCvv = new MaskedTextController(mask: '000');

  String _name;
  String _cardNumber;
  String _date;
  String _cvv;
  String _buttonTitle = "Save";

  @override
  Widget build(BuildContext context) {
    return new Container(
        //key: _scaffoldKey,
        child: new Container(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: new Form(
                  key: formKey,
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new TextFormField(
                          controller: controllerName,
                          decoration: new InputDecoration(labelText: 'Name'),
                          validator: (value) =>
                              value.isEmpty ? 'Card name can\'t be empty' : null,
                          onSaved: (value) => _name = value,
                        ),
                        new TextFormField(
                          controller: controllerCard,
                          decoration:
                              new InputDecoration(labelText: 'Card number'),
                          keyboardType: TextInputType.number,
                          validator: (value) => value.isEmpty
                              ? 'Card number can\'t be empty'
                              : null,
                          onSaved: (value) => _cardNumber = value,
                        ),
                        Row(
                          children: <Widget>[
                            new Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                                child: new TextFormField(
                                  controller: controllerDate,
                                  decoration: new InputDecoration(
                                      labelText: 'Expiry date'),
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) => value.isEmpty
                                      ? 'Expiry date can\'t be empty'
                                      : null,
                                  onSaved: (value) => _date = value,
                                ),
                              ),
                            ),
                            new Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                child: new TextFormField(
                                  controller: controllerCvv,
                                  decoration:
                                      new InputDecoration(labelText: 'CVV'),
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  validator: (value) => value.isEmpty
                                      ? 'CVV can\'t be empty'
                                      : null,
                                  onSaved: (value) => _cvv = value,
                                ),
                              ),
                            ),
                          ],
                        ),
                        new RaisedButton(
                            onPressed: savePaymentsDetails,
                            child: new Text(
                              _buttonTitle,
                              style: new TextStyle(color: Colors.white),
                            ),
                            color: Colors.green)
                      ])),
            )));
  }

  savePaymentsDetails() async {
    final form = formKey.currentState;

    //print to console
    if (form.validate()) {
      // if valid then save.
      form.save();
      print(
          'Valid payment details. name: $_name, cardNumber: $_cardNumber, exp date: $_date , cvv: $_cvv');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      //bool save = prefs.getBool("isIntro") ?? false;
      await prefs.setString(LocalDB.payment_card_name, _name);
      await prefs.setString(LocalDB.payment_card_number, _cardNumber);
      await prefs.setString(LocalDB.payment_card_exp_date, _date);
      await prefs.setString(LocalDB.payment_card_cvv, _cvv);

      print("Payments info saved");
    }
  }

  getSavedPaymentMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var name = prefs.getString(LocalDB.payment_card_name);
    var card = prefs.getString(LocalDB.payment_card_number);
    var date = prefs.getString(LocalDB.payment_card_exp_date);
    var cvv = prefs.getString(LocalDB.payment_card_cvv);

    if (name != null && card != null && date != null && cvv != null) {
      setState(() {
        controllerName.text = name;
        controllerCvv.updateText(cvv);
        controllerDate.updateText(date);
        controllerCard.updateText(card);

        _buttonTitle = "Update";
      });
    }
  }
}
