import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets/TodoItem.dart';

class Section extends StatelessWidget {
  final String heading;
  final List<TodoItem> todoItemList;

  Section({this.heading, this.todoItemList});

  @override
  Widget build(BuildContext context) {
    // TODO: Style section item here.
    return Column(
      children: <Widget>[
        Container(alignment: AlignmentDirectional.centerStart,child: Text
          (heading),padding: EdgeInsets.only(left: 16, top: 25,right: 16,
            bottom: 16)),
        Column(children: todoItemList)
      ],
    );
  }
}
