import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets/TodoItem.dart';
import 'package:flutter_todo/Sections/TodoLists/NewTodoPage.dart';

class PendingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Todos'),
    ),
      body: Center(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
              return TodoItem(index,);
          },
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
              NewTodoPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

}

