import 'package:flutter/material.dart';

class TodaySection extends StatelessWidget {
  final String heading;
  final List<Dismissible> todoItemList;

  TodaySection({this.heading, this.todoItemList});

  @override
  Widget build(BuildContext context) {
    // TODO: Style section item here.
    return Column(
      children: <Widget>[
        Container(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              heading,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.only(left: 16, top: 25, right: 16, bottom: 16)),
        Card(child: Column(children: todoItemList),margin: EdgeInsets.only
          (left:0,right: 0,top: 0,bottom: 10),elevation: 0,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
    ),)
      ],
    );
  }
}
