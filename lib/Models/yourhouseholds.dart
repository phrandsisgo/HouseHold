import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class YourHouseholds extends StatefulWidget {
  @override
  _YourHouseholdsState createState() => _YourHouseholdsState();
}

class _YourHouseholdsState extends State<YourHouseholds> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return ListTile(
      title: Row(children: [  
        Expanded(child: Text(
          document['irgendwass'],
        )),
      ],),
    );
  }
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Haushalte').doc('Feldstrassse').snapshots(),
      builder:(context, snapshot){
        if(!snapshot.hasData) return const Text('loading data');
        ListView.builder(
          itemCount: snapshot.data,
          itemBuilder: (context, index)=>
          _buildListItem(context, snapshot.data.documents),
          
        );
      })
      // ListView())
    ;
  }
}