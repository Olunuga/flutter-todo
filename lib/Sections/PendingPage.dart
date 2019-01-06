import 'package:flutter/material.dart';

class PendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Todos'),
    ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            //Navigate back to first screen
          },
          child: Text('Go back'),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

}