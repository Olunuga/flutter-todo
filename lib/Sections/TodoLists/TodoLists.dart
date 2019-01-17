import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets/TodoItem.dart';
import 'package:flutter_todo/Sections/TodoLists/NewTodoPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingPage extends StatelessWidget {
  List<DocumentSnapshot> documentSnapshotList;

  _onTodoClicked({isChecked,identifier}){
    //update firebase here
    print('ischecked is $isChecked and identifier is $identifier');
    Firestore.instance.collection("Todos").document(identifier).updateData({'completed':isChecked});
  }



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
              default:{
                documentSnapshotList = snapshot.data.documents;

                return new ListView(
                  children: snapshot.data.documents.map((DocumentSnapshot document) {
                    print(document.data);
                    documentSnapshotList = snapshot.data.documents;
                    return new TodoItem(document.documentID,document["text"],
                        document["completed"],_onTodoClicked);
                  }).toList(),
                );
              }
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
        tooltip: 'Add todo',
        child: Icon(Icons.add),
      ),
    );
  }

}



