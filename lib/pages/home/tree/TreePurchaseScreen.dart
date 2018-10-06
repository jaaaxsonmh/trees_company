import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trees_co/pages/Settings/SettingPages/PaymentDetails.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/LocalDB.dart';
import 'package:trees_co/utils/MoneyConverter.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import 'package:trees_co/widgets/Poster.dart';

class TreePurchaseScreen extends StatefulWidget {
  final DocumentSnapshot detail;

  TreePurchaseScreen(this.detail);

  @override
  State<StatefulWidget> createState() {
    var screen = new _TreePurchaseScreen(detail);
    screen.totalPriceOfThisOrder = detail[Fire.TREE_PRICE];
    screen._checkCardAndAddress();
    return screen;
  }
}

class _TreePurchaseScreen extends State<TreePurchaseScreen> {
  final DocumentSnapshot detail;

  final formKey = new GlobalKey<FormState>();

  int _radioValue = -1;

  static const int DELIVERY = 0;
  static const int PICK_UP = 1;

  String _treeType;
  String _treeAge;

  bool isCreditCardInfoSaved = false;
  bool isDeliveryAddressInfoSaved = false;

  String lastCreditCard = "";
  String lastDeliveryAddress = "";
  String fullDeliveryAddressHolder = "";
  String fullDeliveryAddress = "";

  _TreePurchaseScreen(this.detail);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int totalPriceOfThisOrder = 0;

  int QYT = 1;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case DELIVERY:
          fullDeliveryAddress = fullDeliveryAddressHolder;
          break;
        case PICK_UP:
          fullDeliveryAddress = "Pickup";
      }
    });
  }

  Future _openDialogCreditCard() async {
    await MyNavigator.goToPayments(context);

    _checkCardAndAddress();

    setState(() {});
  }

  Future _openDialogDeliveryInfo() async {
    await MyNavigator.goToDelivery(context);

    _checkCardAndAddress();

    setState(() {});
  }

  _checkCardAndAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var nameCard = prefs.getString(LocalDB.payment_card_name);
    var cardCard = prefs.getString(LocalDB.payment_card_number);
    var dateCard = prefs.getString(LocalDB.payment_card_exp_date);
    var cvvCard = prefs.getString(LocalDB.payment_card_cvv);

    if (nameCard != null &&
        cardCard != null &&
        dateCard != null &&
        cvvCard != null) {
      isCreditCardInfoSaved = true;
      lastCreditCard = cardCard;
    } else {
      isCreditCardInfoSaved = false;
    }

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
      isDeliveryAddressInfoSaved = true;
      lastDeliveryAddress = address;
      fullDeliveryAddressHolder =
          "$name, $number, $address, $suburb, $city, $postCode";
    } else {
      isDeliveryAddressInfoSaved = false;
    }

    setState(() {});
  }

  _buildDeliveryAddress() {
    var addressUI;
    if (_radioValue == DELIVERY) {
      if (isDeliveryAddressInfoSaved) {
        addressUI = Wrap(
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0,
          children: <Widget>[
            new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                child: new Icon(
                  Icons.done,
                  color: Colors.green,
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
              child: Text("Deliver to " + lastDeliveryAddress),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
              child: new RaisedButton(
                  onPressed: _openDialogDeliveryInfo,
                  child: Text("Change", style: TextStyle(color: Colors.white)),
                  color: Colors.blue),
            )
          ],
        );
      } else {
        addressUI = new RaisedButton(
            onPressed: _openDialogDeliveryInfo,
            child: Text("Add delivery address",
                style: TextStyle(color: Colors.white)),
            color: Colors.blue);
      }
    } else {
      addressUI = Text("");
    }

    return new Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            child: Text("Pickup or Delivery"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Radio(
                value: DELIVERY,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              new Text(
                'Delivery',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: PICK_UP,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              new Text(
                'Pick up',
                style: new TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          addressUI
        ],
      ),
    );
  }

  _buildCreaditCardWidget() {
    if (isCreditCardInfoSaved) {
      return new Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(
                padding: EdgeInsets.all(05.0),
                child: new Icon(
                  Icons.done,
                  color: Colors.green,
                )),
            Text("Use " + lastCreditCard + " card"),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
              child: new RaisedButton(
                  onPressed: _openDialogCreditCard,
                  child: Text("Change", style: TextStyle(color: Colors.white)),
                  color: Colors.blue),
            )
          ],
        ),
      );
    } else {
      return new RaisedButton(
          onPressed: _openDialogCreditCard,
          child: Text(
            "We need your cardit card info",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue);
    }
  }

  _buildCategoryChips(TextTheme textTheme) {
    return <Widget>[
      new RaisedButton(
          onPressed: contunuePurchaseFlow,
          textColor: Colors.white,
          color: Colors.blue,
          child: new Text("Continue")),
      _getQYTContols(textTheme)
    ];
  }

  _getQYTContols(TextTheme textTheme) {
    var title = detail[Fire.TREE_TITLE];

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Quantity: " + QYT.toString()),
            new GestureDetector(
              onTap: () {
                QYT++;

                _scaffoldKey.currentState.removeCurrentSnackBar();
                _scaffoldKey.currentState
                    .showSnackBar(SnackBar(content: Text(title + " +1")));

                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
                if (QYT > 0) {
                  QYT--;

                  _scaffoldKey.currentState.removeCurrentSnackBar();
                  _scaffoldKey.currentState
                      .showSnackBar(SnackBar(content: Text(title + " -1")));
                }

                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var price = MoneyConverter().convert(totalPriceOfThisOrder * QYT);

    var textTheme = Theme.of(context).textTheme;

    var movieInformation = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Text(
            detail[Fire.TREE_TITLE],
            style: textTheme.title,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: new Text(
            price,
            style: textTheme.title.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).accentColor),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: new Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            direction: Axis.horizontal,
            children: _buildCategoryChips(textTheme),
          ),
        ),
        new Padding(padding: const EdgeInsets.only(top: 70.0))
      ],
    );

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
          backgroundColor: Colors.green[800],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Product Options'),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new Icon(Icons.add_shopping_cart))
            ],
          )),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Poster(
                    detail[Fire.TREE_IMAGE],
                    height: 190.0,
                  ),
                ),
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: movieInformation,
                  ),
                ),
              ],
            ),

            // They will need to specify the tree type and the approximate age or height as well as the quantity. The actual price will be given then.

            new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextFormField(
                        decoration: new InputDecoration(labelText: 'Tree type'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value.isEmpty ? 'Input desiged tree type' : null,
                        onSaved: (value) => _treeType = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextFormField(
                        decoration:
                            new InputDecoration(labelText: 'Approximate age'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => value.isEmpty
                            ? 'Input desiged tree age (height)'
                            : null,
                        onSaved: (value) => _treeAge = value,
                      ),
                    )
                  ],
                )),
            _buildCreaditCardWidget(),
            _buildDeliveryAddress()
          ],
        ),
      ),
    );
  }

  contunuePurchaseFlow() async {
    final form1 = formKey.currentState;

    var allGud = false;

    if (form1.validate() &&
        fullDeliveryAddress != "" &&
        lastCreditCard != "") {
      addToShoppingCardDb();
    } else {
      if (fullDeliveryAddress == "") {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Please selected delivery or pickup"),
        ));
      }

      if (lastCreditCard == "") {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Please add payment info"),
        ));
      }
    }
  }

  addToShoppingCardDb() async {
    Firestore.instance
        .collection(Fire.shoppingCart)
        .where(Fire.SHOPPING_CART_ITEM_TITLE,
            isEqualTo: detail[Fire.TREE_TITLE])
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot.documents.isEmpty) {
        Map<String, dynamic> values = {
          Fire.SHOPPING_CART_ITEM_PRICE: detail[Fire.TREE_PRICE],
          Fire.SHOPPING_CART_ITEM_IMAGE: detail[Fire.TREE_IMAGE],
          Fire.SHOPPING_CART_ITEM_QUANTITY: QYT,
          Fire.SHOPPING_CART_ITEM_TITLE: detail[Fire.TREE_TITLE],
          Fire.SHOPPING_CART_TIME: new DateTime.now(),
          Fire.SHOPPING_CART_ITEM_TYPE: "Tree",
          Fire.SHOPPING_CART_ITEM_DELIVERY_PICKUP: fullDeliveryAddress,
          Fire.SHOPPING_CART_ITEM_TREE_AGE: _treeAge,
          Fire.SHOPPING_CART_ITEM_TREE_TYPE: _treeType,
        };

        Firestore.instance.collection(Fire.shoppingCart).add(values);
      } else {
        querySnapshot.documents.forEach((value) {
          Map<String, dynamic> values = {
            Fire.SHOPPING_CART_ITEM_QUANTITY:
                value[Fire.SHOPPING_CART_ITEM_QUANTITY] + QYT,
          };

          Firestore.instance
              .collection(Fire.shoppingCart)
              .document(value.documentID)
              .updateData(values);
        });
      }

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(detail[Fire.TREE_TITLE] + " added to shopping cart"),
        action: SnackBarAction(
            label: "View",
            onPressed: () {
              Navigator.pop(context);
              MyNavigator.goToCart(context);
            }),
      ));
    });
  }
}
