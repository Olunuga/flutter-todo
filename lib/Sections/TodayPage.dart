import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets/TodoItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
                      return new TodoItem(0,document["text"]);
                    }).toList(),
                  );
              }
            },
          )
      ),
    );
  }
}