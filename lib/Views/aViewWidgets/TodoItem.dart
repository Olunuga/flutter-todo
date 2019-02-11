import 'package:flutter/material.dart';
import 'package:flutter_todo/Views/aViewWidgets/CustomCheckbox.dart';

typedef OnItemClicked = void Function({bool isChecked, String identifier});
typedef OnEditItemClicked = void Function({String identifier, String text});
typedef OnDeleteItemClicked = void Function({String identifier});

class TodoItem extends StatelessWidget {
  final String identifier;
  final String text;
  final bool completed;
  final OnItemClicked onItemClicked;
  final OnEditItemClicked onEditItemClicked;
  final OnDeleteItemClicked onDeleteItemClicked;

  TodoItem(this.identifier, this.text, this.completed, this.onItemClicked,
      this.onEditItemClicked, this.onDeleteItemClicked);



  void _onCheckBoxChange() {
    onItemClicked(isChecked: !completed, identifier: identifier);
  }

  void _handleOnEditItemClicked(){
    print("Edit todo item was clicked");
    onEditItemClicked(identifier: identifier, text : text);
  }

  void _handleOnDeleteItemClicked(){
    print("Edit todo item was clicked");
    onDeleteItemClicked(identifier: identifier);
  }


  void _voidCall(isChecked) => _onCheckBoxChange();

  @override
  Widget build(BuildContext context) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(child: Container(
              margin: EdgeInsets.only(right: 15),
              child: CustomCheckbox(
                  value: completed,
                  materialTapTargetSize: null,
                  onChanged: _voidCall,
                  useTapTarget: false,
                  activeColor: completed? Colors.grey: Colors.teal),
            ),
            onTap: _onCheckBoxChange,
            ),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector( child:Text(
                    text,
                    style: TextStyle(
                        color: completed? Colors.black54: Colors.black87,
                        fontWeight:
                    FontWeight.w500,
                        decoration: completed? TextDecoration.lineThrough:null),
                  ),
                    onTap: _onCheckBoxChange,
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: _handleOnEditItemClicked, child: Text("EDIT")),
                                  FlatButton(
                                      onPressed: _handleOnDeleteItemClicked, child: Text("DELETE"))
                                ],
                              ),
                             ),
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
      );
  }
}
