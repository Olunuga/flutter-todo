import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_todo/UI//AccountPage.dart';
import 'package:flutter_todo/UI/TodoLists/TodoLists.dart';
import 'package:flutter_todo/UI//TodayPage.dart';

void main() {
  debugPaintSizeEnabled= false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MainPage(title: 'Todo'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final _widgetOptions = [
    TodayPage(),
    PendingPage(),
    AccountPage()
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),


      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text
              ('Today')),
            BottomNavigationBarItem(icon: Icon(Icons.list), title: Text
              ('Todos')),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text
              ('Account'))
          ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

    );
  }
}

