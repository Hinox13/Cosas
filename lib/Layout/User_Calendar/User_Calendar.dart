import 'package:flutter/material.dart';

class User_Calendar extends StatefulWidget {
  @override
  _User_CalendarState createState() => _User_CalendarState();
}

class _User_CalendarState extends State<User_Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Calendar'),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 500,
          child: Placeholder(),
        ),
      ),
    );
  }
}
