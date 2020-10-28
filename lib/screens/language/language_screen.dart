import 'package:flutter/material.dart';
import 'package:subanimals/remote/request/request_handler.dart';

import 'package:subanimals/models/items.dart';
import 'package:subanimals/utils/manager.dart';
import 'package:subanimals/utils/constants.dart';
import 'package:subanimals/models/settings.dart';
import 'package:subanimals/remote/queries/query.dart';
import 'package:subanimals/screens/language/widgets/itemWidget.dart';

class Languages extends StatefulWidget {
  @override
  _LanguagesState createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  RequestHandler _client = RequestHandler();
  List<Items<String>> list;
  List<Setting> ls = List<Setting>();
  bool selected = false;
  dynamic data;
  dynamic code;

  @override
  void initState() {
    super.initState();
    _getLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.language),
        title: Text("Select Language"),
      ),
      body: Center(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return _itemBuilder(index);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: list.length),
      ),
      floatingActionButton: _buildButton(),
    );
  }

  _getLanguages() async {
    list = [];

    data = await _client.by('languages', langQuery, sync: true);
    Map.fromIterable(data, key: (e) {
      setState(() {
        list.add(Items<String>(e["name"]));
      });
    });
  }

  Widget _itemBuilder(int index) {
    return ItemWidget(
      name: list[index].data,
      isSelected: list[index].isSelected,
      index: index,
      callback: () {
        for (int i = 0; i < list.length; i++) {
          if (i == index) {
            list[i].isSelected = true;
          } else {
            list[i].isSelected = false;
          }
        }
        _onItemSelected(list[index].data);
      },
    );
  }

  _onItemSelected(index) {
    Map.fromIterable(data, key: (e) {
      if (index == e["name"]) {
        setState(() {
          selected = true;
          code = e["code2"];
        });
      }
    });
  }

  _buildButton() {
    return selected
        ? IconButton(
            icon: Icon(Icons.send, color: Colors.grey[900]),
            iconSize: 50.0,
            onPressed: () async {
              final _prefs = await PreferenceManager.getInstance();
              _prefs.setItem("lang", code);
              dynamic data = await _client.by('settings', settingQuery);
              Map.fromIterable(data, key: (e) {
                _prefs.setItem(e["title"], e["status_id"]);
              });
              Navigator.popAndPushNamed(context, screenSignUp);
            },
          )
        : IconButton(
            icon: Icon(Icons.send, color: Colors.grey[300]),
            iconSize: 50.0,
          );
  }
}
