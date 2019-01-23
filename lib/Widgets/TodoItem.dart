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
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: <Widget>[
                      Chip(
                        label: Text("Work"),
                        labelStyle: TextStyle(fontSize: 9, color: Colors.black),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: FlatButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: null, child: Text("EDIT")),
                                  FlatButton(
                                      onPressed: null, child: Text("DELETE"))
                                ],
                              ),
                              onPressed: null,
                            )),
                      ),
                    ],
                  ),
                  Divider(height: 2, color: Colors.black12)
                ],
              ),
            )
          ],
        ),
        padding: EdgeInsets.only(right: 16, top: 16, left: 16),
        margin: EdgeInsets.only(bottom: 5),
      ),
      onTap: _onCheckBoxChange,
    );

    return detector;
  }
}
