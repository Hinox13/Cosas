import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecte_visual/classes.dart';
import 'package:projecte_visual/funcions.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class AddUser extends StatefulWidget {
  Group group;
  AddUser({this.group}); 
 @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String barcode = '';
  Uint8List bytes = Uint8List(200);
  
  @override
    initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
  String idgru = this.widget.group.id;
    return  Scaffold(
        appBar: AppBar(
          title: Text('Scanner'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 200,
                child: 
                Image.memory(bytes),
              ),
              RaisedButton(onPressed: _scan, child: Text("Escanejar amb la càmera")),
              RaisedButton(onPressed: _scanPhoto, child: Text("Escanejar QR des de la galeria")),
            ],
          ),
        ),
      );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    //setState(() => this.barcode = barcode);
    // Firestore.instance
    //                       .collection('group')
    //                       .document(idgru)
    //                       .collection('assets')
    //                       .add({'name': _controllerName.text});
    //addNewUser(barcode,idgru);
    Navigator.of(context).pop();
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    setState(() => this.barcode = barcode);
  }
}
        