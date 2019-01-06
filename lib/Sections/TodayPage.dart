import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets//CustomCheckbox.dart';

class TodayPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Today'),
    ),

      body: Center(
          child: ListView.builder(
              itemBuilder: (BuildContext context, int index){
             for (var i = 0; i < 10; i ++){
              return TodoItem(index);
            }
          })
      ),
    );
  }
}



class TodoItem extends StatefulWidget{
  TodoItem(this.index);
  final int index;

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
                child:  Text('This is supposed to be a long text that should '
                    'wrap around using softwrap',
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
