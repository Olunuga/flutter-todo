import 'package:flutter/material.dart';
import 'package:flutter_todo/Widgets/Section.dart';
import 'package:flutter_todo/Widgets/TodoItem.dart';
import 'package:flutter_todo/UI/TodoLists/NewTodoPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingPage extends StatelessWidget {
  List<DocumentSnapshot> documentSnapshotList;

  _onTodoClicked({isChecked,identifier}){
    //update firebase here
    print('ischecked is $isChecked and identifier is $identifier');
    Firestore.instance.collection("Todos").document(identifier).updateData({'completed':isChecked});
  }

  _onEditTodoClicked({identifier}){
    print('I want to edit $identifier');
  }


  List<Section> _generateLists(AsyncSnapshot<QuerySnapshot> snapshot){

    List<TodoItem> pendingList = List<TodoItem>();
    List<TodoItem> completedList = List<TodoItem>();

    snapshot.data.documents.forEach((document){

        TodoItem todoItem = TodoItem(document.documentID, document["text"],
            document["completed"],
            _onTodoClicked, _onEditTodoClicked);

        if(document['completed'] == true){
          completedList.add(todoItem);
        }else{
          pendingList.add(todoItem);
        }

    });

    Section completedSection;
    if(completedList.length > 0){
      completedSection = Section(heading:"Completed",
        todoItemList:completedList);
    }

    Section pendingSection;
    if(pendingList.length > 0){
      pendingSection = Section(heading:"Pending",
          todoItemList:pendingList);
    }

    List<Section> sectionList = List<Section>();
    if(pendingSection != null){
      sectionList.add(pendingSection);
    }

    if(completedSection != null){
      sectionList.add(completedSection);
    }

    return sectionList;
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
                  children: _generateLists(snapshot),
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



