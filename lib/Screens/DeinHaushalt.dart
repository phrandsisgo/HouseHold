import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuehlschrank_app/Constants/constants.dart';
import 'package:kuehlschrank_app/Models/yourhouseholds.dart';
//import 'package:kuehlschrank_app/Models/Users.dart';
import 'package:kuehlschrank_app/Screens/Brew_list.dart';
import 'package:kuehlschrank_app/Screens/Menu.dart';
import 'package:kuehlschrank_app/Screens/TestchooseHome.dart';
import 'package:kuehlschrank_app/Screens/addItem.dart';
import 'package:kuehlschrank_app/Services/Authentifizierig.dart';
import 'package:kuehlschrank_app/Services/Datenbank.dart';
import 'package:kuehlschrank_app/Widgets/ItemsOfHousehold.dart';
import 'package:kuehlschrank_app/Widgets/streamitems.dart';
import 'package:kuehlschrank_app/Widgets/yournameTitle.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class DeinKuehlschrank extends StatefulWidget {
  @override
  _DeinKuehlschrankState createState() => _DeinKuehlschrankState();
}

class _DeinKuehlschrankState extends State<DeinKuehlschrank> {
  void getData() {
    final databaseReference = FirebaseFirestore.instance;
  }

  String formHaushalt;

  final AuthService _firebaseAuth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _dateString = 'random String(dont mind me)';
  //String uid;
  String yourNickname = 'nullNickname';
  String itemTitle;
  String mainhousehold = 'defaultVAlue';
  String theHousehold;
  String docStreamer;
  
  void newEntry() {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: TextField(),
          );
        });
  }
   setDocStreamer(){
     FirebaseFirestore.instance
        .collection('Haushalte')
        .doc(theHousehold)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        docStreamer = '${documentSnapshot.data()["Items"]}';
        return docStreamer;
      }
    });print(theHousehold);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('UsersById')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        theHousehold = '${documentSnapshot.data()["household"]}'
            .toString()
            .replaceAll(' ', '');
      }
    });
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: YournameTitle(),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _firebaseAuth.abmeldung();
            },
          ),
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push<Widget>(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => TestHome()));
              }),
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.push<Widget>(
                    context,
                    MaterialPageRoute<Widget>(
                        builder: (BuildContext context) => Menu()));
              }),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Center(
        child: StreamItems(),
      ),
      
      floatingActionButton: StreamBuilder<DocumentSnapshot>(

          stream: FirebaseFirestore.instance
              .collection('Haushalte')
              .doc(theHousehold)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              focusColor: Colors.green,
              backgroundColor: Colors.green,
              onPressed: () {
                //    newEntry();

                showDialog<AlertDialog>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text('Edit name and date of your Item.'),
                          content: Column(
                            children: [
                              TextField(
                                onChanged: (val) {
                                  setState(() {
                                    itemTitle = val;
                                  });
                                },
                              ),
                              Text(_dateString),
                              RaisedButton(
                                  child: Text('Enter the Date'),
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            helpText:
                                                'Enter the expiration Date of your Item',
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2010),
                                            lastDate: DateTime(2030))
                                        .then((val) {
                                      setState(() {
                                        _dateString = val.toString();
                                        print(_dateString);
                                      });
                                    });
                                  }),/*
                              RaisedButton(
                                child: Text('test random function'),
                                onPressed: () { FirebaseFirestore.instance
        .collection('Haushalte')
        .doc('SomeHousehold')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        theHousehold = '${documentSnapshot.data()["Items"]}'
            .toString()
            .replaceAll(' ', '');
      }
    });print(theHousehold);
                                },
                              ),*/
                              Row(
                                children: [
                                  RaisedButton(
                                    child: Text('ADD'),
                                    onPressed: () {
                                      setState(){ FirebaseFirestore.instance
        .collection('UsersById')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        theHousehold = '${documentSnapshot.data()["household"]}'
            .toString()
            .replaceAll(' ', '');
      }
    });}
                                      String streamingHousehold = "Items";

                                      var firstMap =
                                          snapshot.data[streamingHousehold];
                                      var secondMap = {
                                        itemTitle: _dateString
                                            .toString()
                                            .replaceAll(' 00:00:00.000', '')
                                      };
                                      Map<String, dynamic> mainmap = {};
                                      mainmap.addAll(firstMap);
                                      mainmap.addAll(secondMap);
                                      
                                      FirebaseFirestore.instance
                                          .collection('Haushalte')
                                          .doc(theHousehold)
                                          .update({'Items': mainmap});
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RaisedButton( 
                                    child: Text('cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ));
                    });
              },
            );
          }),
    );
  }
}
