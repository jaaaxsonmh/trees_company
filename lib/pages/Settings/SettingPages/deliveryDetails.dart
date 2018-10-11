import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:trees_co/utils/LocalDB.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    var state = new _DeliveryDetailsState();
    state.getSavedPaymentMethod();
    return state;
  }

  Map<String, String> getLocalDatabaseValid() {
    return {
      "delivery_recipient_name": "",
      "delivery_house_number": "",
      "delivery_street_address": "",
      "delivery_suburb_name": "",
      "delivery_city_name": "",
      "delivery_post_code": ""
    };
  }

  Map<String, String> getLocalDatabaseNotValid() {
    return {
      "delivery_recipient_name": null,
      "delivery_house_number": null,
      "delivery_street_address": null,
      "delivery_suburb_name": null,
      "delivery_city_name": null,
      "delivery_post_code": null
    };
  }

}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  var controllerName = new TextEditingController();
  var controllerNumber = new TextEditingController();
  var controllerAddress = new TextEditingController();
  var controllerSuburb = new TextEditingController();
  var controllerCity = new TextEditingController();
  var controllerPostCode = new MaskedTextController(mask: '0000');

  String _name;
  String _number;
  String _address;
  String _suburb;
  String _city;
  String _postCode;
  String _buttonTitle = "Save";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
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
                            validator: (value) => value.isEmpty
                                ? 'Recipient name can\'t be empty'
                                : null,
                            onSaved: (value) => _name = value,
                          ),
                          Row(
                            children: <Widget>[
                              new Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: new TextFormField(
                                    controller: controllerNumber,
                                    decoration: new InputDecoration(
                                        labelText: 'Street Number'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) => value.isEmpty
                                        ? 'Street Number can\'t be empty'
                                        : null,
                                    onSaved: (value) => _number = value,
                                  ),
                                ),
                              ),
                              new Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 0.0, 0.0),
                                  child: new TextFormField(
                                    controller: controllerAddress,
                                    decoration: new InputDecoration(
                                        labelText: 'Address'),
                                    validator: (value) => value.isEmpty
                                        ? 'Address can\'t be empty'
                                        : null,
                                    onSaved: (value) => _address = value,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              new Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: new TextFormField(
                                    controller: controllerSuburb,
                                    decoration: new InputDecoration(
                                        labelText: 'Suburb'),
                                    validator: (value) => value.isEmpty
                                        ? 'Suburb can\'t be empty'
                                        : null,
                                    onSaved: (value) => _suburb = value,
                                  ),
                                ),
                              ),
                              new Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 0.0, 0.0),
                                  child: new TextFormField(
                                    controller: controllerPostCode,
                                    keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(
                                        labelText: 'Post code'),
                                    validator: (value) => value.isEmpty
                                        ? 'Post code can\'t be empty'
                                        : null,
                                    onSaved: (value) => _postCode = value,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          new TextFormField(
                            controller: controllerCity,
                            decoration: new InputDecoration(labelText: 'City'),
                            validator: (value) => value.isEmpty
                                ? 'City name can\'t be empty'
                                : null,
                            onSaved: (value) => _city = value,
                          ),
                          new RaisedButton(
                              onPressed: saveDeliveryDetails,
                              child: new Text(
                                _buttonTitle,
                                style: new TextStyle(color: Colors.white),
                              ),
                              color: Colors.green)
                        ])),
              ))),
    );
  }

  saveDeliveryDetails() async {
    final form = formKey.currentState;

    //print to console
    if (form.validate()) {
      // if valid then save.
      form.save();
      print(
          'Valid delivery details. Name: $_name, Number: $_number, Address: $_address, Suburb: $_suburb, City: $_city, PostCode: $_postCode');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      //bool save = prefs.getBool("isIntro") ?? false;
      await prefs.setString(LocalDB.delivery_recipient_name, _name);
      await prefs.setString(LocalDB.delivery_house_number, _number);
      await prefs.setString(LocalDB.delivery_street_address, _address);
      await prefs.setString(LocalDB.delivery_suburb_name, _suburb);
      await prefs.setString(LocalDB.delivery_city_name, _city);
      await prefs.setString(LocalDB.delivery_post_code, _postCode);

      print("Delivery info saved");
    }
  }

  getSavedPaymentMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var name = prefs.getString(LocalDB.delivery_recipient_name);
    var number = prefs.getString(LocalDB.delivery_house_number);
    var address = prefs.getString(LocalDB.delivery_street_address);
    var suburb = prefs.getString(LocalDB.delivery_suburb_name);
    var city = prefs.getString(LocalDB.delivery_city_name);
    var postCode = prefs.getString(LocalDB.delivery_post_code);

    if (name != null &&
        number != null &&
        address != null &&
        suburb != null &&
        city != null &&
        postCode != null) {
      setState(() {
        controllerName.text = name;
        controllerNumber.text = number;
        controllerAddress.text = address;
        controllerSuburb.text = suburb;
        controllerCity.text = city;

        controllerPostCode.updateText(postCode);

        _buttonTitle = "Update";
      });
    }
  }
}
