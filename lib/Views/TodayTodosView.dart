import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/Views/aViewWidgets/TodaySection.dart';
import 'package:flutter_todo/Views/aViewWidgets/TodayTodoItem.dart';

class TodayPage extends StatelessWidget {
  _onTodoClicked({isChecked, identifier}) {
    print('ischecked is $isChecked and identifier is $identifier');
    Firestore.instance
        .collection("Todos")
        .document(identifier)
        .updateData({'completed': isChecked});
  }

  _onEditTodoClicked({identifier, text}) {}


  List<TodaySection> _generateLists(AsyncSnapshot<QuerySnapshot> snapshot) {

    List<TodayTodoItem> pendingList = List<TodayTodoItem>();
    List<TodayTodoItem> completedList = List<TodayTodoItem>();


    snapshot.data.documents.forEach((document) {
      if (document['isToday']) {
        TodayTodoItem todayTodoItem = TodayTodoItem(document.documentID, document["text"],
            document["completed"], _onTodoClicked, _onEditTodoClicked);
        if(document['completed']){
          completedList.add(todayTodoItem);
        }else{
          pendingList.add(todayTodoItem);
        }
      }
    });

    TodaySection completedSection;
    if (completedList.length > 0) {
      completedSection =
          TodaySection(heading: "Completed", todoItemList: completedList);
    }

    TodaySection pendingSection;
    if (pendingList.length > 0) {
      pendingSection = TodaySection(heading: "Pending", todoItemList: pendingList);
    }

    List<TodaySection> sectionList = List<TodaySection>();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
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
              return new ListView(
                children:_generateLists(snapshot)
              );
          }
        },
      )),
    );
  }
}
