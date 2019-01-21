import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets/CustomCheckbox.dart';

typedef OnItemClicked = void Function({bool isChecked, String identifier});

class TodoItem extends StatelessWidget {
  TodoItem(this.identifier, this.text, this.completed, this.onItemClicked);

  final String identifier;
  final String text;
  final bool completed;
  final OnItemClicked onItemClicked;

  void _onCheckBoxChange() {
    onItemClicked(isChecked: !completed, identifier: identifier);
  }

  void _voidCall(isChecked) => {};

  @override
  Widget build(BuildContext context) {
    GestureDetector detector = GestureDetector(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 15),
              child: CustomCheckbox(
                  value: completed,
                  materialTapTargetSize: null,
                  onChanged: _voidCall,
                  useTapTarget: false,
                  activeColor: Colors.teal),
            ),
            Column(
              children: <Widget>[
                Text(text),
                Container(
                    child: FlatButton(
                        child: Text("Edit"),
                      onPressed: null,
                    )
                )
              ],
            ),
          ],
        ),
        padding: EdgeInsets.all(16.0),
      ),
      onTap: _onCheckBoxChange,
    );

    return detector;
  }
}
