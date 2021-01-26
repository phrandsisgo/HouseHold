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
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth authentifizierig = FirebaseAuth.instance;
  String formHaushalt;

  String usersId;
  String usersEmail;
  bool ok;
  String inviteUser;
  int randomHaushaltNR;
  String nameOfCurrentHousehold = "no Name yet";
  
String targetName;
  DocumentReference currentHousehold = FirebaseFirestore.instance
      .collection('UsersById')
      .doc(FirebaseAuth.instance.currentUser.uid);
  writenotification(String notificationMessage) {
    FirebaseFirestore.instance
        .collection('UsersById')
        .doc(usersId)
        .update({'Notification': notificationMessage});
  }
  getTargetname(){
   //  String targetName;
                                      FirebaseFirestore.instance
                                      .collection('UsersByEmail')
                                      .doc(inviteUser)
                                      .get()
                                      .then((DocumentSnapshot documentSnapshot) {
                                        targetName= '${documentSnapshot.data()["uid"]}';
                                       /* if (targetName == null){
                                          targetName="noTarget";
                                          print('notarget print');
                                        }else{
                                          targetName="notnull";
                                          print('notnull print');
                                        }*/
                                      });
  }
  setNotification(){
    
                                      FirebaseFirestore.instance
                                      .collection('UsersById')
                                      .doc(targetName)
                                      .update({
                                        'Notification': FirebaseAuth.instance.currentUser.uid
                                      });
  }

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
        body: Center(
            child: Column(children: [
          RaisedButton(
            onPressed: () async {
              print(FirebaseAuth.instance.currentUser.uid);
            },
            child: Text('print Test'),
          ),
          Text('this is the page to maintain your Database'),
          Form(
              child: Column(children: [
            Text(
              'the Name cannot contain space character',
              //need to do a valuation to see if it contains a space bar
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            Text(
              'create a new Haushalts database!',
              style: TextStyle(fontSize: 20, color: Colors.green[900]),
            ),
            //      SizedBox(height:10),
            TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'your Householdname'),
                onChanged: (val) {
                  setState(() {
                    formHaushalt = val;
                  });
                }),
            StreamBuilder<DocumentSnapshot>(
                //currentHousehold is just the document of current users uid
                stream: currentHousehold.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  var firstMap = snapshot.data['Haushalte'];
                  dynamic formErgebnis = formHaushalt;
                  var secondMap = {formHaushalt: formErgebnis};

                  return FlatButton(
                    child: Text('Create Household'),
                    onPressed: () {
                      Map<String, dynamic> thirdMap = {};
                      thirdMap.addAll(firstMap);
                      thirdMap.addAll(secondMap);
                      print(thirdMap.toString());
                      FirebaseFirestore.instance
                          .collection('UsersById')
                          .doc(auth.currentUser.uid)
                          .update({'Haushalte': thirdMap});
                      FirebaseFirestore.instance
                          .collection('Haushalte')
                          .doc(formHaushalt)
                          .set({
                        'Name': formHaushalt,
                        'creator': auth.currentUser.uid,
                        'authUsers': [auth.currentUser.uid],
                        'Items': {}
                      });
                      Navigator.pop(context);
                    },
                  );
                }),
            FlatButton(
              child: Text('Invite to your  current household'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      FirebaseFirestore.instance
                          .collection('UsersById')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .get()
                          .then((DocumentSnapshot documentSnapshot) {
                        if (documentSnapshot.exists) {
                          setState(() {
                            nameOfCurrentHousehold =
                                '${documentSnapshot.data()["household"]}';
                          });
                        }
                      });
                      return AlertDialog(
                        title:
                            Text('Who do you want to invite to your Household'),
                        content: Column(
                          children: [
                            Text(
                                'You want to invite someone to your current DataBase ' +
                                    nameOfCurrentHousehold +
                                    ' Household!'),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              onChanged: (val) {
                                setState(() {
                                  inviteUser = val;
                                });
                              },
                              decoration: InputDecoration(
                                hintText:
                                    "enter here the person you're looking to add",
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RaisedButton(
                              child: Text('Add person'),
                              onPressed: () {
                                //get value of the Form()
                                //check if the 
                                print('add person initialized');
                                  FirebaseFirestore.instance
                                    .collection('UsersByEmail')
                                    .doc(inviteUser)//inviteUser is the value of Form
                                    .get()
                                    .then((onexist) {
                                      onexist.exists ? ok=true : ok = false;
                                    });
                                    if (ok=true){
                                      //if true gets the uid behind the Email and stores it in targetName
                                      getTargetname();
                                      print(targetName.toString()+'is the target');
                                      //set a notification on the targets uid entry.
                                      setNotification();
                                      /*
                                      FirebaseFirestore.instance
                                      .collection('UsersById')
                                      .doc(targetName)
                                      .update({
                                        'Notification': FirebaseAuth.instance.currentUser.uid
                                      });
                                      print('notification have been injected');
                                    }else{
                                      print("Notification haven't been arrived on the target");*/
                                    }
                              },
                            ),
                            RaisedButton(
                                child: Text('Exit'),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                        actions: [],
                      );
                    });
              },
            ),
          ]))
        ])));
  }
}
