import 'package:flutter/material.dart';

Map model  = {
  "entities": {
    "drawer": {
      "drawerAttributes": {
        "elevation": 4.0,
      },
      "drawerHeader": {
        "userName": "Developer",
        "userEmail": "developer@development.com",
        "backgroundColor": Colors.grey,
        "icon": Icon(Icons.person, color: Colors.white),
        "decoration": BoxDecoration(color: Colors.blue,),
        "padding": EdgeInsets.zero,
      },
      "drawerEntities": [
        {
          "title": Text('Home Page'),
          "leading": Icon(Icons.home),
        },
        {
          "title": Text('My Account'),
          "leading": Icon(Icons.person),
        },
        {
          "title": Text('My Orders'),
          "leading": Icon(Icons.shopping_basket),
        },
        {
          "title": Text('Categories'),
          "leading": Icon(Icons.dashboard),
        },
        {
          "title": Text('Favourites'),
          "leading": Icon(Icons.favorite),
        },
        {
          "title": Text('Settings'),
          "leading": Icon(Icons.settings),
        },
        {
          "title": Text('About'),
          "leading": Icon(Icons.help, color: Colors.blue,),
        },
      ]
    },
    "bottomNavBar": {
      "navBarAttributes": {
        "backgroundColor": ThemeData.dark().backgroundColor,
        "type": BottomNavigationBarType.fixed,
        "selectedItemColor": Colors.white,
        "selectedLabelStyle": TextStyle(color: Colors.grey,),
        "unselectedItemColor": Colors.blueGrey,
        "unselectedLabelStyle": TextStyle(color: Colors.blueGrey,),
      },
      "navBarItems": [
        {
          "icon": Icon(Icons.dashboard, color: Colors.blue[900],),
          "activeIcon": Icon(Icons.dashboard, color: Colors.grey[900]),
          "label": "Dashboard"
        },
        {
          "icon": Icon(Icons.message, color: Colors.blue[900]),
          "activeIcon": Icon(Icons.message, color: Colors.grey[900]),
          "label": "Messages"
        },
        {
          "icon": Icon(Icons.attach_money, color: Colors.blue[900]),
          "activeIcon": Icon(Icons.attach_money, color: Colors.grey[900]),
          "label": "Accounts"
        },
        {
          "icon": Icon(Icons.settings, color: Colors.blue[900]),
          "activeIcon": Icon(Icons.settings, color: Colors.grey[900]),
          "label": "Settings"
        }
      ]
    },
    "appBar": {
      "tabsAttributes": {
        "labelColor": Colors.grey[900],
      },
      "tabs": [
        {
          "string": "Place String Here",
          "icon": Icon(Icons.add),
          "iconMargin": EdgeInsets.only(bottom: 8.0),
        },
        {
          "string": "Place String Here",
          "icon": Icon(Icons.add),
          "iconMargin": EdgeInsets.only(bottom: 8.0)
        },
        {
          "string": "Place String Here",
          "icon": Icon(Icons.add),
          "iconMargin": EdgeInsets.only(bottom: 8.0)
        }
      ],
      "tabViews": [
        {
          "icon": Icon(Icons.directions_car),
        },
        {
          "icon": Icon(Icons.directions_car),
        },
        {
          "icon": Icon(Icons.directions_car),
        }
      ],
      "appBarDropDown": {
        "icon": Icons.more_vert,
        "color": Colors.white
      },
      "appBarSearch": {
        "icon": Icons.search,
        "color": Colors.white,
        "inBar": false,
        "hintText": 'Search'
      },
      "title": {
        "text": "DashBoard",
        "textStyle": TextStyle(color: Colors.white),
        "centerTitle": true
      },
      "elevation": 4.0,
      "shadowColor": Colors.black,
      "leading": Icons.menu
    },
    "floatingActionButton": {
      "tooltip": "",
      "elevation": 4.0,
      "shape": RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      "backgroundColor": Colors.white,
      "foregroundColor": Colors.white,
      "focusColor": Colors.white,
      "hoverColor": Colors.white,
    }
  },
  "permissions": {
    "drawer": true,
    "bottomNavBar": true,
    "appBar": {
      "appBarDropDown": true,
      "appBarSearch": true,
      "title": true,
      "tabBarAndView": false,
    },
    "floatingActionButton": false
  }
};