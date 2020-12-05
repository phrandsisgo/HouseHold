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
     //     IconButton(icon: Icon(Icons.arrow_downward), onPressed: (){
   //         print(Something().haupthaushalt.toString());
     //      FirebaseFirestore.instance.collection('UsersById').doc(FirebaseAuth.instance.currentUser.uid).get().then((DocumentSnapshot documentSnapshot){ if(documentSnapshot.exists){print('Document Data ${documentSnapshot['household']}');}});
     //      }))
          ItemsOfHousehold()
          
          /* Column(
            children: [
              Text(
                'Hier kommt noch eine Liste mit allen Lebensmittel rein.',
              ),
              SizedBox(
                height: 30,
              ),
              BrewList(),
              RaisedButton(
                onPressed: () async {
                  final User user = auth.currentUser;
                  uid = user.uid;
                  FirebaseFirestore.instance
                      .collection('UsersById')
                      .doc(uid)
                      .update({
                    'Neue Zahl': FieldValue.arrayUnion(['Hallo'])
                  });
                },
                child: Text('SammlungsErweiterung für ref'),
              ),

              ///Haushalte/FranciscosHaushalt/Inhalt //path to desired Test Colelction
              RaisedButton(
                onPressed: () async {
                  print(auth.currentUser.uid);
                },
                child: Text('Print uid'),
              ),
              Text(
                'Hier kannst du dich abmelden',
                style: TextStyle(fontSize: 25),
              ),
              RaisedButton(
                onPressed: () {
                  //_yournickname();
                  //in current state nicknames dont return object.
                  FirebaseFirestore.instance
                      .collection('UsersById')
                      .doc(auth.currentUser.uid)
                      .get()
                      .then((DocumentSnapshot documentSnapshot) {
                    yourNickname = 'Nickname wurde aufgerufen';
                    print(auth.currentUser.uid);
                    if (documentSnapshot.exists) {
                      yourNickname = 'documentSnapshot does exist';
     //                 _yournickname();
                     // print('${documentSnapshot.get('Nickname')}');
                    }
                  });
                  // print('hallos');
                },
                child: Text('return current User'),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () async {
                  await _firebaseAuth.abmeldung();
                },
                child: Text('Abmeldung'),
              ),
            ],
          ),*/
       ) );
    //  );
    
  }
}
