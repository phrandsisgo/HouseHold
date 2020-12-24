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
    //  databaseReference.collection('brews').getDocuments().
  }
  //test5

  String formHaushalt;

  final AuthService _firebaseAuth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  //final firestoreInstance = FirebaseFirestoe.instance
  String _dateString='random String(dont mind me)';
  //String uid;
  String yourNickname = 'nullNickname';
  String itemTitle;
  String mainhousehold='defaultVAlue';
  void newEntry(){
     showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(

          ),
        );
      }
    );
  }/*
  void changemainhousehold = FirebaseFirestore.instance
      .collection('UsersById')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get().then((DocumentSnapshot documentSnapshot){
        mainhousehold= '${documentSnapshot.toString()}';
      });*/
  var abc = FirebaseFirestore.instance
      .collection('UsersById')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        focusColor: Colors.green,
        backgroundColor: Colors.green,
        onPressed: () {
      //    newEntry();
          
          showDialog<AlertDialog>(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
            title: Text('Edit name and date of your Item.'),
            content: Column(
              children: [
          //      Text('hello there'),
                TextField(onChanged: (val){
                  setState(() {
                    itemTitle=val;
                  });
                },),
                Text(_dateString),
                RaisedButton(child: Text('Enter the Date'), onPressed:(){
                    
          showDatePicker(
                  context: context,
                  helpText: 'Enter the expiration Date of your Item',
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2030))
              .then((val) {
                setState(() {
                  _dateString = val.toString();
                  print(_dateString);
                });
              });
                  }),
                  RaisedButton(child:Text('test random function'),onPressed: (){
                    
                  },),
                Row(children: [
                  RaisedButton(child: Text('ADD'),onPressed: (){
                    Map<String,dynamic> mainmap={itemTitle:_dateString.toString().replaceAll(' 00:00:00.000', '')};
                   // print(mainmap.runtimeType.toString());
                    
                    FirebaseFirestore.instance.collection('Haushalte').doc('pfizer').update(
                      {'Items':{
                        mainmap
                      }});
                    FirebaseFirestore.instance.collection('Haushalte').doc('pfizer').update(
                      {'Items':{
                        itemTitle:_dateString.toString().replaceAll(' 00:00:00.000', '')
                      }});
                        print('abc');

                 //   FirebaseFirestore.instance.collection('Haushalte').doc();

                  },),
                  RaisedButton(child: Text('cancel'),onPressed: (){
                    Navigator.pop(context);
                  },),
                  
                ],)
              ],
            )
            
          );}
          );

         
        },
      ),
    );
    //  );
  }
}
