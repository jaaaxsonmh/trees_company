import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trees_co/pages/LoginPage.dart';
import 'package:trees_co/pages/Settings/SettingPages/PaymentDetails.dart';
import 'package:trees_co/pages/Settings/SettingPages/deliveryDetails.dart';
import 'package:trees_co/utils/LocalDB.dart';
import 'package:trees_co/utils/auth.dart';

class MockAuth extends Mock {}

class Mock {}

void main() {
  testWidgets('delivery info tests, widget test', (WidgetTester tester) async {
    bool stateIsNotNull = false;
    DeliveryDetails page = DeliveryDetails();

    var state = page.createState();

    stateIsNotNull = state != null;

    expect(stateIsNotNull, true);
  });

  test('delivery info tests, valid info', () async {
    DeliveryDetails page = DeliveryDetails();
    Map<String, String> prefs = page.getLocalDatabaseValid();

    var name = prefs[(LocalDB.delivery_recipient_name)];
    var number = prefs[(LocalDB.delivery_house_number)];
    var address = prefs[(LocalDB.delivery_street_address)];
    var suburb = prefs[(LocalDB.delivery_suburb_name)];
    var city = prefs[(LocalDB.delivery_city_name)];
    var postCode = prefs[(LocalDB.delivery_post_code)];

    if (name != null &&
        number != null &&
        address != null &&
        suburb != null &&
        city != null &&
        postCode != null) {
      expect(true, true);
    } else {
      expect(false, true);
    }
  });

  test('delivery info tests, NOT valid info', () async {
    DeliveryDetails page = DeliveryDetails();
    Map<String, String> prefs = page.getLocalDatabaseNotValid();

    var name = prefs[(LocalDB.delivery_recipient_name)];
    var number = prefs[(LocalDB.delivery_house_number)];
    var address = prefs[(LocalDB.delivery_street_address)];
    var suburb = prefs[(LocalDB.delivery_suburb_name)];
    var city = prefs[(LocalDB.delivery_city_name)];
    var postCode = prefs[(LocalDB.delivery_post_code)];

    if (name == null &&
        number == null &&
        address == null &&
        suburb == null &&
        city == null &&
        postCode == null) {
      expect(true, true);
    } else {
      expect(false, true);
    }
  });
}
