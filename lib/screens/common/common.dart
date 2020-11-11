import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:subanimals/utils/manager.dart';
import 'package:subanimals/utils/constants.dart';
import 'package:subanimals/screens/models/forms.dart';
import 'package:subanimals/remote/request/request_handler.dart';
import 'package:subanimals/screens/auth/googleauth/google_login.dart';
import 'package:subanimals/screens/auth/facebookauth/facebook_login.dart';

Widget appBar(String name, dynamic context) {
  String text;
  switch(name) {
    case 'signIn' : text = 'signUp'.toUpperCase();
    break;
    case 'signUp' : text = 'signIn'.toUpperCase();
  }
  return AppBar(
    actions: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: RaisedButton(
          color: Colors.grey[400],
          child: Text(text),
          onPressed: () {
            switch (name) {
              case 'signIn': Navigator.popAndPushNamed(context, screenSignUp);
              break;
              case 'signUp': Navigator.popAndPushNamed(context, screenSignIn);
            }

          },
        ),
      ),
    ],
  );
}

Widget headerSection(String name) {
  return Container(
    margin: EdgeInsets.only(top: 50.0),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
    child: Center(
      child: Text(name,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    ),
  );
}

buidSnackBar(String value) {
  return new SnackBar(
    content: new Text(
        value.toUpperCase() +' FAILED',
        style: TextStyle(color: Colors.white)
    ),
    duration: new Duration(seconds: 3),
    backgroundColor: Colors.black,
  );
}

Future<dynamic> createMap(String key) async {
  var map = new Map<String, dynamic>();
  var user = new Map<String, dynamic>();
  final _prefs = await PreferenceManager.getInstance();
  map['device_type'] = 'android';
  map['device_id'] = 'DeviceTokenGeneratedViaFMC';
  switch(key) {
    case "signUp":
      map['username'] = _prefs.getItem("Email");
      map['password'] = _prefs.getItem("Password");
      user["customer"] = map;
      break;
    case "signIn":
      map['username'] = _prefs.getItem("Email");
      map['password'] = _prefs.getItem("Password");
      map['app'] = 'customer';
      user["session"] = map;
      break;
    case "facebook_login":
      map['app'] = 'customer';
      map['access_token'] = await _prefs.getItem("token");
      user["facebook"] = map;
      break;
  }

  return user;
}

Widget buildAppBar(model) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: DefaultTabController(
        length: model['tabs'].length,
        child: Column(
          children: [
            TabBar(
              labelColor: model['tabsAttributes']['labelColor'],
              tabs: getTabs(model['tabs']),
            ),
          ],
        ),
      ),
    ),
    title: Text(model['title']['text']),
    centerTitle: model['title']['centerTitle'],
    actions: [
      IconButton(
          icon: Icon(model['appBarSearch']['icon']),
          color: model['appBarSearch']['color'],
          onPressed: () {}
      ),
      IconButton(
          icon: Icon(model['appBarDropDown']['icon']),
          color: model['appBarDropDown']['color'],
          onPressed: () {}
      )
    ],
  );
}

Widget buildDrawer(model) {
  List list = model['drawer']['drawerEntities'];

  return Drawer(
    elevation: model['drawer']['drawerAttributes']['elevation'],
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(
                  // backgroundColor: model['drawer']['drawerHeader']['backgroundColor'],
                  child: model['drawer']['drawerHeader']['icon'],
                  radius: 36,
                ),
              ),
              Text(model['drawer']['drawerHeader']['userName']),
              Text(model['drawer']['drawerHeader']['userEmail']),
            ],
          ),
        ),
        Column(
          children: getDrawerItems(list),
        )
      ],
    ),
  );
}

Widget buildBottomNavBar(model) {
  List items = model['bottomNavBar']['navBarItems'];

  return BottomNavigationBar(
    items: getNavBarItems(items),
    type: model["bottomNavBar"]["type"],
    selectedItemColor: model["bottomNavBar"]["selectedItemColor"],
    selectedLabelStyle: model["bottomNavBar"]["selectedLabelStyle"],
    unselectedLabelStyle: model["bottomNavBar"]["unselectedItemColor"],
  );
}

getTabs(List list) {
  List<Widget> items = [];
  list.forEach((entity) {
    items.add(Tab(icon: entity['icon']));
  });

  return items;
}

getNavBarItems(List items) {
  List<BottomNavigationBarItem> list = [];
  items.forEach((entity) {
    list.add(BottomNavigationBarItem(
        icon: entity['icon'],
        label: entity['label'],
        activeIcon: entity['activeIcon']
    ));
  });

  return list;
}

getDrawerItems(List list) {
  List<Widget> items = [];
  list.forEach((entity) {
    items.add(InkWell(
      onTap: () {},
      child: ListTile(
        title: entity['title'],
        leading: entity['leading'],
      ),
    ));
  });

  return items;
}