import 'package:flutter/material.dart';

class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Today'),
    ),
      body: Center(
          child: Text('Hello Today with no floating button')
      ),
    );
  }

}