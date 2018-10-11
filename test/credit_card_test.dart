import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trees_co/pages/LoginPage.dart';
import 'package:trees_co/pages/Settings/SettingPages/PaymentDetails.dart';
import 'package:trees_co/utils/auth.dart';


class MockAuth extends Mock {}

class Mock {
}

void main() {

  testWidgets('credit card tests, valid info', (WidgetTester tester) async {

    bool stateIsNotNull = false;
    PaymentDetails page = PaymentDetails();

    var state = page.createState();

    stateIsNotNull = state != null;

    expect(stateIsNotNull, true);
  });


}