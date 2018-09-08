import 'package:flutter/material.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import 'package:trees_co/widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.green),
    PlaceholderWidget(Colors.red),
    PlaceholderWidget(Colors.amber),
    PlaceholderWidget(Colors.deepOrange)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Plant a Tree'),
      ),
      body: _children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Home'),

        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.new_releases),
          title: new Text('News'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.add_a_photo),
          title: new Text('Location'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.add_shopping_cart),
          title: new Text('Catelog'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}