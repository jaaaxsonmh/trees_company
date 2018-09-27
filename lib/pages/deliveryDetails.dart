
import 'package:flutter/material.dart';


class DeliveryDetails  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DeliveryDetailsState();
  }
}

class _DeliveryDetailsState extends State<DeliveryDetails> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Delivery Details'),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                  new Icon(Icons.home)
              )
            ],
          )
      ),

    );
  }
}

class secureData {
  String name = '';
  String houseNumber = '';
  String houseAddress = '';
  String postCode = '';
  String specialInstructions = '';
}