import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Todo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;

  final _widgetOptions = [
    TodayPage(),
    PendingPage(),
    CompletedPage()
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            BottomNavigationBarItem(icon: Icon(Icons.done_all), title: Text('Completed'))
          ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

    );
  }
}

class PendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Todos'),
    ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
          //Navigate back to first screen
        },
          child: Text('Go back'),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

}

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

class CompletedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Completed'),
    ),
      body: Center(
          child: Text('Hello Completed ')
      ),
    );
  }

}
