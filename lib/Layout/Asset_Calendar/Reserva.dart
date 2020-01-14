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
    String idgroup,
    String assetid,
    String userid,
    DateTime dayselected,
    List<dynamic> selectedEvents) {
  DateTime initTime;
  DateTime finishTime;
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
      titlePadding: EdgeInsets.all(0),
      title: Row(
        children: <Widget>[
          Expanded(
              child: Container(
                  color: Colors.orange,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, bottom: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${dayselected.year}',
                          style: TextStyle(color: Colors.white54),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${m(dayselected)}, ${dayselected.day}',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Start Time (hh:mm)', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 15),
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
            isShowSeconds: false,

            onTimeChange: (time) {
              initTime = time;
              //La variable time conté la hora d'inici en tipus DateTime
            },
          ),
          SizedBox(height: 30),
          Text('Finish Time (hh:mm)', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 15),
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
            isShowSeconds: false,
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
            Event e = Event(userid, assetid, t[0], t[1]);
            bool valid = validationReserve(t, selectedEvents);

            if (valid == true) {
              Firestore.instance.collection('event').add(e.toFirestore());

              Navigator.of(context).pop(t);
            } else {
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
  );
}

String m(DateTime tm) {
  switch (tm.month) {
    case 1:
      return "January";
      break;
    case 2:
      return "February";
      break;
    case 3:
      return "March";
      break;
    case 4:
      return "April";
      break;
    case 5:
      return "May";
      break;
    case 6:
      return "June";
      break;
    case 7:
      return "July";
      break;
    case 8:
      return "August";
      break;
    case 9:
      return "September";
      break;
    case 10:
      return "October";
      break;
    case 11:
      return "November";
      break;
    case 12:
      return "December";
      break;
  }
}
