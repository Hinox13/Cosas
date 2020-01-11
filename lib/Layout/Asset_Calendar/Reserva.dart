import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:projecte_visual/classes.dart';
import 'package:projecte_visual/funcions.dart';
import 'package:fluttertoast/fluttertoast.dart';

FutureOr inReserve(
    BuildContext context,
    List<DateTime> temp,
    String idgroup,
    String assetid,
    String userid,
    DateTime dayselected,
    List<dynamic> selectedEvents) {
  DateTime initTime;
  DateTime finishTime;
  var toast;

  List<DateTime> timeOnDaySelected(
      DateTime init, DateTime finish, DateTime dayselected) {
    List<DateTime> timefixed = [
      DateTime(dayselected.year, dayselected.month, dayselected.day, init.hour,
          init.minute, init.second),
      DateTime(dayselected.year, dayselected.month, dayselected.day,
          finish.hour, finish.minute, finish.second)
    ];
    return timefixed;
  }

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      title: Text('Reserve'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Start Time', style: TextStyle(color: Colors.grey)),
          TimePickerSpinner(
            //TimePickerSpinner per introduir l'hora d'inici
            normalTextStyle: TextStyle(
              fontSize: 12,
            ),
            highlightedTextStyle: TextStyle(
              fontSize: 20,
            ),
            itemHeight: 30,
            is24HourMode: true,
            isShowSeconds: true,
            onTimeChange: (time) {
              initTime = time;
              print(
                  initTime); //La variable time conté la hora d'inici en tipus DateTime
            },
          ),
          SizedBox(height: 30),
          Text('Finish Time', style: TextStyle(color: Colors.grey)),
          TimePickerSpinner(
            //TimePickerSpinner per introduir l'hora final
            normalTextStyle: TextStyle(
              fontSize: 12,
            ),
            highlightedTextStyle: TextStyle(
              fontSize: 20,
            ),
            itemHeight: 30,
            is24HourMode: true,
            isShowSeconds: true,
            onTimeChange: (time2) {
              finishTime = time2;
              print(
                  finishTime); //La variable time conté la hora final en tipus DateTime
            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Reserve'),
          onPressed: () {
            List<DateTime> t =
                timeOnDaySelected(initTime, finishTime, dayselected);
            //List<DateTime> t = [initTime, finishTime];
            Event e = Event(userid, assetid, t[0], t[1]);
            bool valid = validationReserve(t, selectedEvents);

            if (valid == true) {
              Firestore.instance.collection('event').add(e.toFirestore());
              Navigator.of(context).pop(t);
            }
            // if(valid == false){
            //   Navigator.of(context).pop(t);
            // }
            else {
              Fluttertoast.showToast(
                  msg: "Error message! Your booking is not available",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 2,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 12.0);
              Navigator.of(context).pop();
            }
          },
        ),
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  ).then((time) {
    if (time != null) print(temp);

    temp = time;
  });
}
