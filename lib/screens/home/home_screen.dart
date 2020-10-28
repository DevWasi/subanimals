import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'package:subanimals/utils/constants.dart';
import 'package:subanimals/screens/settings/settings_screen.dart';
import 'package:subanimals/utils/manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Animals", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            onPressed: () async  {
              final _prefs = await PreferenceManager.getInstance();
              await _prefs.removeItem('status');
              Navigator.popAndPushNamed(context, screenSignUp);
            },
            icon: Icon(Icons.power_settings_new),
          )
        ],
      ),
      body: Center(child: Text("Main Page")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("Header"),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.popAndPushNamed(context, screenSettings);
              },
            ),
          ],
        ),
      ),
    );
  }
}
