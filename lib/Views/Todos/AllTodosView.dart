import 'package:flutter/material.dart';

import 'package:flutter_todo/Views/Todos//NewTodoView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/Views/aViewWidgets/Section.dart';
import 'package:flutter_todo/Views/aViewWidgets/TodoItem.dart';


class AllTodos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AllTodoState();
  }

}

class AllTodoState  extends State<AllTodos> {
  List<DocumentSnapshot> documentSnapshotList;
  BuildContext mContext;

  _onTodoClicked({isChecked, identifier}) {
    //update firebase here
    print('ischecked is $isChecked and identifier is $identifier');
    Firestore.instance
        .collection("Todos")
        .document(identifier)
        .updateData({'completed': isChecked});
  }

  _onEditTodoClicked({identifier, text}) {
    print('I want to edit $identifier');
    Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (context) => NewTodoPage(true, text, identifier)));
  }

  _onDeleteTodoClicked({identifier}) {
    print('I want to delete $identifier');
    Firestore.instance.collection("Todos").document(identifier).delete().catchError(
            (e){
      print(e);
    });
  }

  _handleSwipe({documentId}){
    print("I want to add to todays list");
    Firestore.instance
        .collection("Todos")
        .document(documentId)
        .updateData({'isToday': true});

  }


  List<Section> _generateLists(AsyncSnapshot<QuerySnapshot> snapshot) {
    //TODO: optimizing ,, programmatically create this list if there are
    // multiple items.
    List<Dismissible> pendingList = List<Dismissible>();
    List<Dismissible> completedList = List<Dismissible>();


    snapshot.data.documents.forEach((document) {
      print(document['tags'].toString());
      TodoItem todoItem = TodoItem(document.documentID, document["text"],
          document["completed"], _onTodoClicked, _onEditTodoClicked, _onDeleteTodoClicked);

      var dismissible = Dismissible(
        key: Key(document.documentID),
        child: todoItem,
        onDismissed: (direction){
          if(direction == DismissDirection.startToEnd){
            Scaffold.of(mContext).showSnackBar(SnackBar(content: Text
              ("Swipe to the right")));
          } else if(direction == DismissDirection.endToStart){
            Scaffold.of(mContext).showSnackBar(SnackBar(content: Text("Moved "
                "to todays list")));
            _handleSwipe(documentId:document.documentID);
          }
        },
        direction:document['completed']? null: DismissDirection.endToStart,
        background: Container(color: Colors.teal, child: Text("Move to today",
          style: TextStyle(color: Colors.white),)
            , alignment: Alignment.centerRight,padding: EdgeInsets.only(left:
              0,right: 16,top: 0,bottom: 0),),
      );



      if(!document['isToday']){
      if (document['completed'] == true) {
        completedList.add(dismissible);
      } else {
        pendingList.add(dismissible);
      }
      }
    });

    Section completedSection;
    if (completedList.length > 0) {
      completedSection =
          Section(heading: "Completed", todoItemList: completedList);
    }

    Section pendingSection;
    if (pendingList.length > 0) {
      pendingSection = Section(heading: "Pending", todoItemList: pendingList);
    }

    List<Section> sectionList = List<Section>();
    if (pendingSection != null) {
      sectionList.add(pendingSection);
    }

    if (completedSection != null) {
      sectionList.add(completedSection);
    }

    return sectionList;
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;

    return Scaffold(
      appBar: AppBar(
        title: Text('All Todos'),
      ),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Todos").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              {
                documentSnapshotList = snapshot.data.documents;

                return new ListView(
                  children: _generateLists(snapshot),
                );
              }
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewTodoPage(false, '', '')));
        },
        tooltip: 'Add todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
