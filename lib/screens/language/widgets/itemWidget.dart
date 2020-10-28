import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  final dynamic name;
  final int index;
  final bool isSelected;
  final VoidCallback callback;

  const ItemWidget({
    this.name,
    this.isSelected,
    this.index,
    this.callback
  });


  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.callback();
        },
        child: Container(
          color: widget.isSelected ? Colors.red[100] : Colors.white,
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Center(
            child: ListTile(
              title: Text(
                widget.name,
                style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
