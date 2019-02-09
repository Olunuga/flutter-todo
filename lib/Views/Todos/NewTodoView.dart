import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTodoPage extends StatelessWidget {

  NewTodoPage(this.isEditing, this.mText, this.identifier);

  String mText;
  bool isEditing;
  String identifier;


  BuildContext mContext;

  void _submitInput(text){
    if(!isEditing){
      Firestore.instance.collection('Todos').document()
          .setData({ 'text': text,'completed':false, 'isToday':false,'tags':['w'
          'ork','a'
      'ndroid']});
    }else{
      Firestore.instance.collection('Todos').document(identifier)
          .updateData({ 'text': text});
    }
    Navigator.pop(mContext);
  }

  TextEditingController textEditingController = TextEditingController();

  void _handleSubmit(){
    _submitInput(mText);
  }


  @override
  Widget build(BuildContext context) {
    mContext = context;
    textEditingController.text = mText;
    return Scaffold(appBar: AppBar(
      title: Text('Add todo'),
    ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              maxLines: 2,
              onSubmitted: _submitInput,
              controller: textEditingController,
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
