import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuehlschrank_app/Constants/constants.dart';
import 'package:kuehlschrank_app/Models/yourhouseholds.dart';
//import 'package:kuehlschrank_app/Models/Users.dart';
import 'package:kuehlschrank_app/Screens/Brew_list.dart';
import 'package:kuehlschrank_app/Screens/Menu.dart';
import 'package:kuehlschrank_app/Screens/TestchooseHome.dart';
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
    //  databaseReference.collection('brews').getDocuments().
  }
  //test5

  String formHaushalt;

  final AuthService _firebaseAuth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  //final firestoreInstance = FirebaseFirestoe.instance
  String uid;
  String yourNickname = 'nullNickname';
  
var abc=FirebaseFirestore.instance.collection('UsersById').doc(FirebaseAuth.instance.currentUser.uid).get().then((DocumentSnapshot documentSnapshot){
  return '${documentSnapshot.toString()}';
  print('${documentSnapshot.toString()}');
});
  
  @override
  Widget build(BuildContext context) {
   // return StreamProvider<QuerySnapshot>.value(value: DatabaseService().brews,child:
      return Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: YournameTitle(),
   //       _yournickname(),
     //     Text('Hallo '+auth.currentUser.uid,style: TextStyle(fontSize: 13),),
          actions: [
            IconButton(icon: Icon(Icons.logout),   onPressed: () async {
                  await _firebaseAuth.abmeldung();
                },),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: (){
                Navigator.push<Widget>(context, 
                MaterialPageRoute(builder: (BuildContext context)=> TestHome()));
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
          child: 
          StreamItems(),
       ),floatingActionButton: FloatingActionButton(
         child: Icon(Icons.add),
         focusColor: Colors.green,
         backgroundColor: Colors.green,
       ), );
    //  );
    
  }
}
