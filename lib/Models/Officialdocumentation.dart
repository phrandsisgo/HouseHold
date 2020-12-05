import 'dart:ffi';
import 'Haushalt.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class OfficialDocumentation extends StatefulWidget {
  @override
  _OfficialDocumentationState createState() => _OfficialDocumentationState();
}

class _OfficialDocumentationState extends State<OfficialDocumentation> {
  @override
  
  final FirebaseAuth auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    
    CollectionReference users = FirebaseFirestore.instance.collection('UsersById');
    DocumentReference currentHousehold = FirebaseFirestore.instance.collection('UsersById').doc(auth.currentUser.uid);


    return StreamBuilder<DocumentSnapshot>(
      stream:  currentHousehold.snapshots(),
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
        Map haushaltsmap= Map<String,  dynamic>.from(snapshot.data['Haushalte']);
        String something='hello there, yes i know';
        something.splitMapJoin(',');

        List liste=[];
        haushaltsmap.forEach((key, value) =>liste.add(Haushalte.einzeilig(value)));
        print('irgendwass');
            return ListView.builder(itemBuilder: (context, index){
              print('print of list');
                return ListTile(title: Text(liste[index].toString().replaceAll(',null', '')
                ),onTap: (){print(index.toString());},);
            }, itemCount: liste.length);
      
      },
      
    );
  }
}