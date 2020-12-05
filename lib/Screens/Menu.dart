

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
        title: Text('Menu 1'),
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
            StreamBuilder<DocumentSnapshot>(
              stream:currentHousehold.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                var firstMap =snapshot.data['Haushalte'];
                dynamic formErgebnis = formHaushalt;
                var secondMap = {formHaushalt:formErgebnis};
                
                return FlatButton(child: Text('Hinzufügen Test'),onPressed: (){
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
      //         FirebaseFirestore.instance.collection('UsersById')
                },);
              }),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText:'neuer Haushalt zur Sammlung hinzufügen'),
              onChanged:(val){setState(() {
                formHaushalt=val; 
              });
                
              }
            ),
            FlatButton.icon(icon: Icon(Icons.add),label:Text('Hinzufügen'),
             onPressed:()async{
               print(formHaushalt+' wurde hinzugefügt');
               FirebaseFirestore.instance.collection('UsersById').doc(auth.currentUser.uid).update({
                 'Haushalte':{
                   'hallo':'ich bin hier'
                 }
               });
        //       FirebaseFirestore.instance.collection('UsersById').doc(auth.currentUser.uid).update({'Haushalte':{formHaushalt:formHaushalt}});
           //    FirebaseFirestore.instance.collection('collectionPath').doc('sd').update(data)
               /*
               FirebaseFirestore.instance.collection('UsersById').doc(auth.currentUser.uid).update({
                 'Haushalte': {
                   'haushaltpath':'haushaltname',
                   'haushalerinoweg':'nomal de hushaltname'
                 }
               });*/
               //here i have to make a Function which checks if the collections Document alrdy exists and if not create one damned
               // print(FirebaseFirestore.instance.collection('Haushalte').doc(formHaushalt).get().exists);
               
                 final User user = auth.currentUser;
                 uid = user.uid;
                 await Fridges(fridgename: formHaushalt).newFridge(formHaushalt,uid);
                 print('next line prints uid: '+uid);
                 Navigator.pop(context);
  //     print(uid);
        //        await DatabaseService();
              },
            ),
            RaisedButton(onPressed:() {
              for( var i =0; i<4;i++){
                randomHaushaltNR = i;
              }
              randomHaushaltNR = randm.nextInt(9999);
               String requestFornewHoushold=formHaushalt+ '#'+randomHaushaltNR.toString();
              FirebaseFirestore.instance.collection('Haushalte').doc(requestFornewHoushold).get().then((DocumentSnapshot documentSnapshot){
                if(documentSnapshot.exists){
                  //in dem unteren Block braucht es ein try again
                  print('should get another random haushaltsnummer and try again');
                }else{
                  FirebaseFirestore.instance.collection('Haushalte').doc(requestFornewHoushold).set({
                    'new household': 'remove this item to make a new one'
                  });
                  FirebaseFirestore.instance.collection('UsersById').doc(auth.currentUser.uid).set({
                    'path':'Haushalte/'+requestFornewHoushold
                  });
                  print('make new household');
                }
              });
            },child: Text('does Document Exist?'),)
          ]
        ))

      ]))
      
    );
  }
}