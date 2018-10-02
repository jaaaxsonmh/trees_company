import 'package:flutter_masked_text/flutter_masked_text.dart';

class MoneyConverter{

  String convert(dynamic price){
    var priceDouble = double.parse(price.toString());
    var controller = new MoneyMaskedTextController(leftSymbol: 'NZD\$ ', decimalSeparator: '.', thousandSeparator: ',');
    controller.updateValue(priceDouble);

    return controller.text;
  }

}