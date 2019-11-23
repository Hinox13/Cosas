import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Main_Screen/Main_Screen.dart';
import 'package:projecte_visual/Layout/Class/Models.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoomShare',
      color: Colors.white,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MainScreen(),
    );
  }
}


