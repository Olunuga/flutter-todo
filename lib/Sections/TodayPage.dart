import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets/TodoItem.dart';


class TodayPage extends StatelessWidget {


  void itemClicked(index){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Today'),
    ),

      body: Center(
          child: ListView.builder(
            itemCount: 10,
              itemBuilder: (BuildContext context, int index){
              return TodoItem(index,"Some long text that should be shown to a"
                  " user");

          })
      ),
    );
  }
}