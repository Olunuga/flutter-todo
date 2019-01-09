import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets/CustomCheckbox.dart';

class TodoItem extends StatefulWidget{
  TodoItem(this.index, this.text);

  final int index;
  final String text;


  @override
  State<StatefulWidget> createState()  => TodoItemState();

}

class TodoItemState extends State<TodoItem>{
  bool _checked = false;

  void _onCheckBoxChange(){
    setState(() {
      _checked = !_checked;
    });
  }

  void _voidCall(isChecked) => {};



  @override
  Widget build(BuildContext context) {

    GestureDetector detector  = GestureDetector(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 15),
              child:CustomCheckbox(
                  value: _checked,
                  materialTapTargetSize: null,
                  onChanged: _voidCall,
                  useTapTarget: false,
                  activeColor: Colors.teal),
            ),

            Expanded(
                child:  Text(widget.text,
                  softWrap: true,)
            )

          ],
        ),
        padding: EdgeInsets.all(16.0),
      ),
      onTap: _onCheckBoxChange,
    );

    // TODO: implement build
    return detector;
  }
}

