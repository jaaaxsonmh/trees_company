import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trees_co/pages/Settings/SettingPages/deliveryDetails.dart';
import 'package:trees_co/pages/Settings/SettingPages/PaymentDetails.dart';
import 'package:trees_co/pages/Settings/SettingPages/ProfileDetails.dart';


class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SettingsState();
  }
}

enum StateType { setProfile, showProfile }

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {

  final formKey = new GlobalKey<FormState>();

  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //TODO: revert from scroll view to appbar since it is breaking the forms when keyboard opens
      body: new NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: new Text('Settings'),
              pinned: true,
              backgroundColor: Colors.green,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: buildTabBar,
            ),
          ];
        },
        body: new TabBarView(
          children: <Widget>[
            new ProfileDetails(),
            new PaymentDetails(),
            new DeliveryDetails()
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  TabBar get buildTabBar {
    return new TabBar(
      indicatorColor: Colors.white,
      tabs: <Tab>[
        new Tab(
          text: "Profile",
          icon: new Icon(Icons.person),
        ),
        new Tab(
          text: "Payment",
          icon: new Icon(Icons.payment),
        ),
        new Tab(
          text: "Delivery",
          icon: new Icon(Icons.directions_car),
        ),
      ],
      controller: _tabController,
    );
  }
}