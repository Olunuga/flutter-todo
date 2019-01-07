import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets/TodoItem.dart';

class PendingPage extends StatelessWidget {

  void _handleOnItemClicked(index){

  }

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
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

}