import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets/TodoItem.dart';
import 'package:flutter_todo/Sections/TodoLists/NewTodoPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(
      title: Text('Todos'),
    ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("Todos").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState){
              case ConnectionState.waiting: return new Text('Loading...');
              default:
                return new ListView(
                  children: snapshot.data.documents.map((DocumentSnapshot document) {
                    return new TodoItem(0,document["text"]);
                  }).toList(),
                );
            }
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



