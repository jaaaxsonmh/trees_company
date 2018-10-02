import 'package:flutter/material.dart';
import 'package:trees_co/utils/LocalDB.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import 'package:trees_co/utils/IntroHelper.dart';
import 'package:trees_co/widgets/introAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = new PageController();
  int current = 0;
  int totalPage = 3;
  bool last = false;

  void onPageChange(int page) {
    setState(() {
      current = page;
      if (current == totalPage) {
        last = true;
        _intoPageShownSave();
      } else {
        last = false;
      }
    });
  }

  _intoPageShownSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(LocalDB.isIntro, true);
  }

  // build layout
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.blue,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 3,
              child: PageView(
                children: <Widget>[
                  //tree co welcome
                  IntroAnimation(
                    title: IntroHelper.titleCard1,
                    content: IntroHelper.textCard1,
                    icon: Icons.wc,
                  ),

                  //shopping cart
                  IntroAnimation(
                    title: IntroHelper.titleCard2,
                    content: IntroHelper.textCard2,
                    icon: Icons.add_shopping_cart,
                  ),

                  // verifying orders / delivery
                  IntroAnimation(
                    title: IntroHelper.titleCard3,
                    content: IntroHelper.textCard3,
                    icon: Icons.verified_user,
                  ),

                  // Final card (thank you)
                  IntroAnimation(
                    title: IntroHelper.titleCard4,
                    content: IntroHelper.textCard4,
                    icon: Icons.cake,
                  ),
                ],
                controller: controller,
                onPageChanged: onPageChange,
              ),
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text(last ? "" : IntroHelper.skipCard,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      onPressed: () =>
                          last ? null : MyNavigator.goToHome(context),
                    ),
                    FlatButton(
                      child: Text(
                          last ? IntroHelper.lastCard : IntroHelper.nextCard,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      onPressed: () => last
                          ? MyNavigator.goToHome(context)
                          : controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn),
                    ),
                  ],
                ))
          ],
        ));
  }
}
