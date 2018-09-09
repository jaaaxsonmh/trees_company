import 'package:flutter/material.dart';
import 'package:trees_co/pages/home/news/NewsList.dart';
import 'package:trees_co/pages/home/tools/ToolsList.dart';
import 'package:trees_co/pages/home/tree/TreesList.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    NewsList(),
    TreesList(),
    ToolsList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Plant a tree'), automaticallyImplyLeading: false),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.insert_drive_file),
            title: new Text('News'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.streetview),
            title: new Text('Trees'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.pan_tool), title: Text('Tools'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
