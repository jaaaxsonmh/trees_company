import 'package:flutter/material.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import 'package:trees_co/utils/IntroHelper.dart';
import 'package:trees_co/widgets/introAnimation.dart';


class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = new PageController();
  int current = 0;
  int totalPage = 4;
  bool last = false;

  void onPageChange(int page) {
    setState(() {
      current = page;
      if (current == totalPage) {
        last = true;
      } else {
        last = false;
      }
    });
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
          Expanded(
            flex: 1,
              child: Container()
          ),
          Expanded(
            flex: 3,
            child: PageView(
              children: <Widget>[
                introAnimation(
                  title: IntroHelper.titleCard1,
                  content: IntroHelper.titleCard1,
                  icon: Icons.child_friendly,
                ),
              ],
              controller: controller,
              onPageChanged: onPageChange,
            )
          )

        ],
      )
    );
  }
}
