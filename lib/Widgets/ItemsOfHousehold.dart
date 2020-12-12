import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuehlschrank_app/Models/Haushalt.dart';
import 'package:kuehlschrank_app/Models/Item.dart';
import 'package:provider/provider.dart';

class ItemsOfHousehold extends StatefulWidget {
  @override
  _ItemsOfHouseholdState createState() => _ItemsOfHouseholdState();
}

class _ItemsOfHouseholdState extends State<ItemsOfHousehold> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String householdname;
  
String mainItemSet;

  @override
  Widget build(BuildContext context) {
  //  return Text('just to test it out');

FirebaseFirestore.instance.collection('UsersById')
.doc(FirebaseAuth.instance.currentUser.uid)
.get()
.then((DocumentSnapshot documentSnapshot){
  if(documentSnapshot.exists){
 //   print('Document Data ${documentSnapshot.data()}');
      householdname='${documentSnapshot['household']}';
  }
});
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Haushalte').doc(householdname).snapshots(),
      
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        print(householdname+'should be name');
        if(snapshot.hasError){
          return Text('something went wrong');
        }
        if(!snapshot.hasData){
          return Text('snapshot has no data in database');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text('loading');
        }
        
        Map itemResultMap= Map<String, dynamic>.from(snapshot.data['Items']);
        List liste=[];
        itemResultMap.forEach((key, value) =>liste.add(ItemsInHousehold.einzeilig(value)));
        return ListView.builder(itemBuilder:(context, index){
          mainItemSet= liste[index].toString();
          return ListTile(
            title: Text(liste[index].toString())
          );
        } ,
        itemCount: liste.length,);
      },
    );
  }
}
/*
class GetHouseholdName extends StatelessWidget {
   String documentId;
 // GetHouseholdName(this.documentId);
  @override
  Widget build(BuildContext context) {
    
FirebaseFirestore.instance.collection('UsersById')
.doc(FirebaseAuth.instance.currentUser.uid)
.get()
.then((DocumentSnapshot documentSnapshot){
  if(documentSnapshot.exists){
    print('Document Data ${documentSnapshot.data()}');
  }
});
    return Text('upthere');
  }
}*/