
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  DateTime _dateTime;
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.green,
    appBar: AppBar(
      title: Text('add new Item'),

    ),
    body: Column(
      children:<Widget>[
        Text(_dateTime == null? 'nothing has ben picked yet':_dateTime.toString()),
        ] 
    ),
    );
  }
}