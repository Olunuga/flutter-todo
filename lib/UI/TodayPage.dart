import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets/TodoItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TodayPage extends StatelessWidget {

  _onTodoClicked({isChecked,identifier}){
    print('ischecked is $isChecked and identifier is $identifier');
    Firestore.instance.collection("Todos").document(identifier).updateData({'completed':isChecked});
  }

  _onEditTodoClicked({identifier, text}){

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Today'),
    ),

      body: Center(
          child:StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("Todos").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState){
                case ConnectionState.waiting: return new Text('Loading...');
                default:
                  return new ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return new TodoItem(document.documentID,document["text"],
                          document["completed"], _onTodoClicked,
                          _onEditTodoClicked);
                    }).toList(),
                  );
              }
            },
          )
      ),
    );
  }
}