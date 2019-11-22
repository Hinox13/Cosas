import 'package:flutter/material.dart';

class Profile_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 250,
              height: 250,
              child: Placeholder(),
            ),
            Column(
              children: <Widget>[
                Text('User Name'),
                SizedBox(height: 2),
                Text('#DataName'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 42),
                Column(
                  children: <Widget>[
                    Text('User State'),
                    SizedBox(width: 30),
                    Text('#DataState'),
                    SizedBox(width: 10),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text('Number of groups'),
                SizedBox(height: 2),
                Text('#DataNgroup'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
