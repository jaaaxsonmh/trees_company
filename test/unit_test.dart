import 'package:test/test.dart';
import 'package:trees_co/utils/Routers.dart';

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


  });
}