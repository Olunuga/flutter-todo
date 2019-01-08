import 'package:flutter/material.dart';

class NewTodoPage extends StatelessWidget {

  String mText;
  BuildContext mContext;

  void _submitInput(text){
    //Submit input here
    print(text);
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
