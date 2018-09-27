import 'package:flutter/material.dart';
import 'package:trees_co/pages/home/news/NewsList.dart';
import 'package:trees_co/pages/home/tools/ToolsList.dart';
import 'package:trees_co/pages/home/tree/TreesList.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [NewsList(), TreesList(), ToolsList()];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new UserAccountsDrawerHeader(
            //TODO: pull name from DB
            accountName: new Text('Jack Hosking'),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.white,
              //TODO: add a image selector popup.
              child: new Icon(Icons.add_a_photo),
            ),
            //TODO: pull email from DB
            accountEmail: new Text('jpm8993@autuni.ac.nz'),
            otherAccountsPictures: <Widget>[
              new FlatButton(
                  onPressed: () {
                    showAboutDialog(
                        context: context,
                        applicationName: 'Plant a Tree',
                        applicationIcon:
                            new Image.asset("assets/sprout.png", width: 50.0),
                        applicationVersion: 'version 1.0',
                        applicationLegalese:
                            'Thanks for using Plant A Tree, this was our first flutter project, and we are all happy with the results and learning that came from this.');
                  },
                  child: new Icon(Icons.cake, color: Colors.white)),
              //TODO: add share functionality
              new FlatButton(
                child: new Icon(Icons.share, color: Colors.white),
                onPressed: () { Share.share('Come try out our app download here:');
                },
              ),
              new FlatButton(
                child: new Icon(
                  Icons.rate_review,
                  color: Colors.white,
                ),
                onPressed: () {
                  LaunchReview.launch(
                      androidAppId: 'com.skuu.plantatree',
                      iOSAppId: 'com.skuu.runfinity');
                },
              )
            ],
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),

          /* This shows all the tab items on the drawer menu */
          //TODO: add profile page
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.green,
            ),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.healing,
              color: Colors.green,
            ),
            title: Text('Diagnose Tree Health'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          //TODO: add cart page
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.green,
            ),
            title: Text('View Cart'),
            trailing: new Text(
              '4',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          //TODO: add settings page
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      )),
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
        backgroundColor: Colors.green,
        title: new Text('Plant A Tree',
            style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        fixedColor: Colors.green,
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
