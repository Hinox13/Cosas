import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

FutureOr inReserve(BuildContext context,List<DateTime>temp,String idgroup ,String assetid) {
     DateTime initTime;
      DateTime finishTime;

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
                  List<DateTime> t = [initTime, finishTime];
                   Map<String, dynamic> event = tiempo(t, assetid);
                   Firestore.instance.collection('event').add(event);
                  Navigator.of(context).pop(t);
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
        if (time != null)
    print(temp);
    temp=
      }); 
    }

  Map<String, dynamic> tiempo(dynamic time, String assetid){
    return {
      'end': time[0],
      'init':time[1],
      'assetid':assetid
    };
  }
  