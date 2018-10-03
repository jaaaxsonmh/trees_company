import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:trees_co/utils/LocalDB.dart';

class DeliveryDetails  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DeliveryDetailsState();
  }
}

class _DeliveryDetailsState extends State<DeliveryDetails> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  var controllerPostCode = new MaskedTextController(mask: '0000');

  String _name;
  String _number;
  String _address;
  String _suburb;
  String _city;
  String _postCode;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        body: new Container(
            padding: EdgeInsets.all(10.0),
            child: new Form(
                key: formKey,
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'Name'),
                        validator: (value) =>
                        value.isEmpty ? 'Recipient name can\'t be empty' : null,
                        onSaved: (value) => _name = value,
                      ),
                      Row(
                        children: <Widget>[

                          new Flexible(
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                              child: new TextFormField(
                                decoration: new InputDecoration(
                                    labelText: 'Street Number'),
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                value.isEmpty
                                    ? 'Street Number can\'t be empty'
                                    : null,
                                onSaved: (value) => _number = value,
                              ),
                            ),
                          ),
                          new Flexible(
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                              child: new TextFormField(
                                decoration:
                                new InputDecoration(labelText: 'Address'),
                                validator: (value) =>
                                value.isEmpty
                                    ? 'Address can\'t be empty'
                                    : null,
                                onSaved: (value) => _address = value,
                              ),
                            ),
                          ),
                        ],
                      ),
                      new RaisedButton(
                          onPressed: saveDeliveryDetails,
                          child: new Text(
                            'Save',
                            style: new TextStyle(color: Colors.white),
                          ),
                          color: Colors.green)
                    ]))));
  }
  saveDeliveryDetails() async {
    final form = formKey.currentState;

    //print to console
    if (form.validate()) {
      // if valid then save.
      form.save();
      print(
          'Valid payment details. Name: $_name, Number: $_number, Address: $_address, Suburb: $_suburb, City: $_city, PostCode: $_postCode');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      //bool save = prefs.getBool("isIntro") ?? false;
      await prefs.setString(LocalDB.delivery_recipient_name, _name);
      await prefs.setString(LocalDB.delivery_house_number, _number);
      await prefs.setString(LocalDB.delivery_street_address, _address);
      await prefs.setString(LocalDB.delivery_suburb_name, _suburb);
      await prefs.setString(LocalDB.delivery_city_name, _city);
      await prefs.setString(LocalDB.delivery_post_code, _postCode);


      print("Payments info saved");
    }
  }


}