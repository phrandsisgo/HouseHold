import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class GetMainHousehold{
  final FirebaseAuth auth = FirebaseAuth.instance;

  DocumentReference mainHousehold= FirebaseFirestore.instance.collection('collectionPath').doc('as');
  Widget build(BuildContext context)
  {return StreamBuilder<DocumentSnapshot>(
    stream: mainHousehold.snapshots(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
      if(snapshot.hasError){
          return Text('something went wrong');
        }
        if(!snapshot.hasData){
          return Text('snapshot has no data in database');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text('loading');
        }
      return Text('dsa');
    }
  );}
}
class Something{
FirebaseFirestore.instance.collection('UsersById')
}

/*

    DocumentReference mainHousehold = FirebaseFirestore.instance.collection('UsersById').doc(FirebaseAuth.instance.currentUser.uid).snapshots().toString;
  return StreamBuilder<DocumentSnapshot>(
      stream:  mainHousehold.snapshots(),
      builder:(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot{

      }));*/