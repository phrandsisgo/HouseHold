

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuehlschrank_app/Constants/constants.dart';
import 'package:kuehlschrank_app/Models/Users.dart';
import 'package:kuehlschrank_app/Services/Authentifizierig.dart';
import 'package:kuehlschrank_app/Services/Datenbank.dart';
import 'dart:math';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  
  final AuthService _firebaseAuth = AuthService();
  String uid;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey=GlobalKey<FormState>();
  final FirebaseAuth authentifizierig = FirebaseAuth.instance;
  String formHaushalt;
  int randomHaushaltNR;
  DocumentReference currentHousehold=FirebaseFirestore.instance.collection('UsersById').doc(FirebaseAuth.instance.currentUser.uid);

  
  var randm = new Random();
  void inputData() async {
    
    // here you write the codes to input the data into firestore
  }
  Widget build(BuildContext context) {
   // CollectionReference benutzerUID = FirebaseFirestore.instance.collection('UserById').doc();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Menu'),
      ),
      body:Center(child:
      Column(children:[
        RaisedButton(
                onPressed: () async {
                  print(FirebaseAuth.instance.currentUser.uid);
                },
                child: Text('print Test'),
              ),
        Text('hier kann ich einen neuen Haushalt einrichten'),
        Form(child: Column(
          children:[
            Text('Eine neue HaushaltsDatenbank Einrichten', style: TextStyle(
              fontSize:20,
              color: Colors.green[900]
            ),),
      //      SizedBox(height:10),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText:'neuer Haushalt zur Sammlung hinzufügen'),
              onChanged:(val){setState(() {
                formHaushalt=val; 
              });
                
              }
            ),
            StreamBuilder<DocumentSnapshot>(
              stream:currentHousehold.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                var firstMap =snapshot.data['Haushalte'];
                dynamic formErgebnis = formHaushalt;
                var secondMap = {formHaushalt:formErgebnis};
                
                return 
              FlatButton(child: Text('Hinzufügen Test'),onPressed: (){
               Map<String,dynamic> thirdMap={};
               thirdMap.addAll(firstMap);
               thirdMap.addAll(secondMap);
               print(thirdMap.toString());
               FirebaseFirestore.instance.collection('UsersById').doc(auth.currentUser.uid).update({'Haushalte':thirdMap});
               FirebaseFirestore.instance.collection('Haushalte').doc(formHaushalt).set({
                 'Name':formHaushalt,
                 'creator':auth.currentUser.uid,
                 'authUsers':[auth.currentUser.uid],
                 'Items':{}
               });
               Navigator.pop(context);
      //         FirebaseFirestore.instance.collection('UsersById')
                },);
              }),
          
          ]
        ))

      ]))
      
    );
  }
}