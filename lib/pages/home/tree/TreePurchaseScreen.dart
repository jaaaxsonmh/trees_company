import 'package:flutter/material.dart';
import 'package:trees_co/utils/MoneyConverter.dart';

class TreePurchaseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TreePurchaseScreen();
  }
}

class _TreePurchaseScreen extends State<TreePurchaseScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int totalPriceOfThisOrder = 0;

  @override
  Widget build(BuildContext context) {
    var price = MoneyConverter().convert(totalPriceOfThisOrder);

    return new Scaffold(
      key: _scaffoldKey

    );

  }
}
