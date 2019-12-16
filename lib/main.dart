import 'package:flutter/material.dart';
import 'package:projecte_visual/Layout/Main_Screen/Main_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projecte_visual/Layout/User_Calendar/User_Calendar.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoomShare',
      color: Colors.white,
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: MainScreen(),
    );
  }
}


