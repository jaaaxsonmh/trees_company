import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trees_co/pages/home/news/NewsList.dart';
import 'package:trees_co/pages/home/tools/ToolsList.dart';
import 'package:trees_co/pages/home/tree/TreesList.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import 'package:trees_co/utils/Routers.dart';
import 'package:trees_co/utils/auth.dart';
import 'package:trees_co/pages/IntroScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {


  int _currentIndex = 0;
  int _currentNumberOfItemsInCart = 0;
  int _currentNumberOfItemsInOrders = 0;
  final List<Widget> _children = [NewsList(), TreesList(), ToolsList()];

  static const platform = const MethodChannel(Routers.AR_KEY);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _getNumberOfItemsInCart();

    return new Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
      appBar: buildAppBar(context),
      body: _children[_currentIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              MyNavigator.goToCart(context);
            }),
        IconButton(
            icon: Icon(Icons.assignment),
            onPressed: () {
              MyNavigator.goToMyOrders(context);
            })
      ],
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
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        new UserAccount(),

        // This shows all the tab items on the drawer menu

        ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.green,
          ),
          title: Text('Profile'),
          onTap: () {
            MyNavigator.goToSettings(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.help,
            color: Colors.green,
          ),
          title: Text('Plant Care Information'),
          onTap: () {
            MyNavigator.goToTreeCare(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.healing,
            color: Colors.green,
          ),
          title: Text('Diagnose Tree Health'),
          onTap: () {
            MyNavigator.goToDiagnoseTree(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.camera,
            color: Colors.green,
          ),
          title: Text('Plant a Tree in AR'),
          onTap: () {
            openAR();
          },
        ),
        //TODO: add cart page
        new Divider(color: Colors.green),
        ListTile(
          leading: Icon(
            Icons.shopping_cart,
            color: Colors.green,
          ),
          title: Text('View Cart'),
          trailing: new Text(
            _currentNumberOfItemsInCart.toString(),
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          onTap: () {
            MyNavigator.goToCart(context);
            //Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.assignment,
            color: Colors.green,
          ),
          title: Text('My orders'),
          trailing: new Text(
            _currentNumberOfItemsInOrders.toString(),
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          onTap: () {
            MyNavigator.goToMyOrders(context);
          },
        ),

      ],
    ));
  }



  void openAR() {
    Future<Null> _openAR() async {
      try {
        int result = await platform.invokeMethod('getAr');
      } on PlatformException catch (e) {
        _showDialog();
      }
    }

    _openAR();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("AR is not available"),
          content: new Text("AR is not available on your device"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  _getNumberOfItemsInCart() async {
    Firestore.instance
        .collection(Fire.shoppingCart)
        .getDocuments()
        .then((querySnapshot) {
      var size = querySnapshot.documents.length;

      setState(() {
        _currentNumberOfItemsInCart = size;
      });
    });

    Firestore.instance
        .collection(Fire.orders)
        .getDocuments()
        .then((querySnapshot) {
      var size = querySnapshot.documents.length;

      setState(() {
        _currentNumberOfItemsInOrders = size;
      });
    });
  }
}

class UserAccount extends StatelessWidget {
  const UserAccount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new UserAccountsDrawerHeader(
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
        new ShowAbout(),
        new ShowShare(),
        new ShowReview()
      ],
      decoration: BoxDecoration(
        color: Colors.green,
      ),
    );
  }
}

class ShowReview extends StatelessWidget {
  const ShowReview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      child: new Icon(
        Icons.rate_review,
        color: Colors.white,
      ),
      onPressed: () {
        LaunchReview.launch(
            androidAppId: 'com.skuu.treesco',
            iOSAppId: 'com.skuu.runfinity');
      },
    );
  }
}

class ShowShare extends StatelessWidget {
  const ShowShare({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      child: new Icon(Icons.share, color: Colors.white),
      onPressed: () {
        Share.share('Come try out our app download here:');
      },
    );
  }
}

class ShowAbout extends StatelessWidget {
  const ShowAbout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
        onPressed: () {
          showAboutDialog(
              context: context,
              applicationName: 'Plant a Tree',
              applicationIcon:
                  new Image.asset("assets/sprout.png", width: 50.0),
              applicationVersion: 'version 0.6',
              applicationLegalese:
                  'Thanks for using Plant A Tree, this was our first flutter project, and we are all happy with the results and learning that came from this.');
        },
        child: new Icon(Icons.cake, color: Colors.white));
  }
}
