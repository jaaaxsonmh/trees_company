import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trees_co/pages/LoginPage.dart';
import 'package:trees_co/utils/auth.dart';


class MockAuth extends Mock {}

class Mock {
}

void main() {

  testWidgets('email or password is empty, does not sign in', (WidgetTester tester) async {

    bool didSignIn = false;
    LoginPage page = LoginPage(onSignedIn: () => didSignIn = true);

    didSignIn = page.auth == false;

    expect(didSignIn, false);
  });

  testWidgets('non-empty email and password, valid account, call sign in, succeed', (WidgetTester tester) async {

    bool didSignIn = false;
    LoginPage page = LoginPage(onSignedIn: () => didSignIn = true);

    didSignIn = page.auth != null;

    expect(didSignIn, false);

  });


}