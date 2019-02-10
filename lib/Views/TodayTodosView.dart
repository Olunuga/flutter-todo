import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/Views/aViewWidgets/TodaySection.dart';
import 'package:flutter_todo/Views/aViewWidgets/TodayTodoItem.dart';

class TodayPage extends StatelessWidget {
  BuildContext mContext;
  _onTodoClicked({isChecked, identifier}) {
    print('ischecked is $isChecked and identifier is $identifier');
    Firestore.instance
        .collection("Todos")
        .document(identifier)
        .updateData({'completed': isChecked});
  }

  _onEditTodoClicked({identifier, text}) {}

  _handleSwipe({documentId}) {
    print("I want to add to todays list");
    Firestore.instance
        .collection("Todos")
        .document(documentId)
        .updateData({'isToday': false});
  }

  List<TodaySection> _generateLists(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Dismissible> pendingList = List<Dismissible>();
    List<Dismissible> completedList = List<Dismissible>();

    snapshot.data.documents.forEach((document) {
      if (document['isToday']) {
        TodayTodoItem todayTodoItem = TodayTodoItem(
            document.documentID,
            document["text"],
            document["completed"],
            _onTodoClicked,
            _onEditTodoClicked);

        var item = Dismissible(
          key: Key(document.documentID),
          child: todayTodoItem,
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              Scaffold.of(mContext).showSnackBar(SnackBar(
                  content: Text("Returned to all "
                      "Todos")));
              _handleSwipe(documentId: document.documentID);
            } else if (direction == DismissDirection.endToStart) {
              Scaffold.of(mContext).showSnackBar(SnackBar(
                  content: Text("Moved "
                      "to todays list")));
            }
          },
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Colors.purpleAccent,
            child: Text(
              "Move to "
                  "all todos",
              style: TextStyle(color: Colors.white),
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16, right: 0, top: 0, bottom: 0),
          ),
        );

        if (document['completed']) {
          completedList.add(item);
        } else {
          pendingList.add(item);
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
      pendingSection =
          TodaySection(heading: "Pending", todoItemList: pendingList);
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
    mContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
      ),
      backgroundColor: Color(0xFFEEEEEF),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Todos").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new ListView(children: _generateLists(snapshot));
          }
        },
      )),
    );
  }
}
