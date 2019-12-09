import 'package:flutter/material.dart';

class Add_Group extends StatefulWidget {
  @override
  _Add_GroupState createState() => _Add_GroupState();
}

class _Add_GroupState extends State<Add_Group> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Group')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Group Name'),
              maxLength: 50,
              maxLengthEnforced: false,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Group Description'),
              maxLength: 150,
              maxLengthEnforced: false,
            ),
          ],
        ),
      ),
    );
  }
}
