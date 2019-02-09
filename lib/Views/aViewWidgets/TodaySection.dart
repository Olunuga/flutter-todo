import 'package:flutter/material.dart';
import 'package:flutter_todo/Views/aViewWidgets/TodayTodoItem.dart';
import 'package:flutter_todo/Views/aViewWidgets/TodoItem.dart';


class TodaySection extends StatelessWidget {
  final String heading;
  final List<TodayTodoItem> todoItemList;

  TodaySection({this.heading, this.todoItemList});

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
