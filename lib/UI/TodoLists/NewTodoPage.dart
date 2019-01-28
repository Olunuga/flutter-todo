import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTodoPage extends StatelessWidget {

  String mText;
  bool isEditing;

  BuildContext mContext;

  void _submitInput(text){
    Firestore.instance.collection('Todos').document()
        .setData({ 'text': text,'completed':false,'tags':['work','android']});
    Navigator.pop(mContext);
  }


  void _handleSubmit(){
    _submitInput(mText);
  }


  @override
  Widget build(BuildContext context) {
    mContext = context;
    return Scaffold(appBar: AppBar(
      title: Text('Add todo'),
    ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: _submitInput,
              autofocus: true ,
              onChanged: (text){
                mText = text;

                print(text);
              },
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: _handleSubmit,
        tooltip: 'save',
        child: Icon(Icons.save),
      ),
    );
  }

}
