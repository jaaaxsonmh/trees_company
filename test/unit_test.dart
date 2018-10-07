import 'package:test/test.dart';
import 'package:trees_co/utils/Routers.dart';
import 'package:trees_co/pages/cart/ShoppingCart.dart';

void main() {

  test('Routes testing', () {

    var AR_KEY = Routers.AR_KEY;
    expect(AR_KEY, Routers.AR_KEY);

    var home = Routers.home;
    expect(home, Routers.home);

    var intro = Routers.intro;
    expect(intro, Routers.intro);

    var diagnoseTree = Routers.diagnoseTree;
    expect(diagnoseTree, Routers.diagnoseTree);

    var newsFullInfo = Routers.newsFullInfo;
    expect(newsFullInfo, Routers.newsFullInfo);

    var settings = Routers.settings;
    expect(settings, Routers.settings);

    var delivery = Routers.delivery;
    expect(delivery, Routers.delivery);

    var treeCare = Routers.treeCare;
    expect(treeCare, Routers.treeCare);

    // New Tests for routes
    var login = Routers.login;
    expect(login, Routers.login);

    var  payments = Routers.payments;
    expect(payments, Routers.payments);

    var shopCart = Routers.shopCart;
    expect(shopCart, Routers.shopCart);

    var orders = Routers.orders;
    expect(orders, Routers.orders);

    var splash = Routers.splash;
    expect(splash, Routers.splash);
  });


  test('Quantity Calculation', () {

  });

  test('Apply Discount', () {

  });

  test('Subtotal', () {

  });
}