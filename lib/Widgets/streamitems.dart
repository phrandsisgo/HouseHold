

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuehlschrank_app/Models/Item.dart';
import 'package:provider/provider.dart';
class StreamItems extends StatefulWidget {
  @override
  _StreamItemsState createState() => _StreamItemsState();
  setzeStatus(){
    _StreamItemsState().setState(() {
      
    });
  }
}

class _StreamItemsState extends State<StreamItems> {
  @override
  String mainItemSet;
  String haushalte='Haushalte';
  String theHousehold='pfizer';
  //FirebaseFirestore.instance.collection('Households')
 // StreamSubscription<String>() StreamSubscription = stream.listen();
  Widget build(BuildContext context) {
  FirebaseFirestore.instance.collection('UsersById')
  .doc(FirebaseAuth.instance.currentUser.uid)
  .snapshots().listen((DocumentSnapshot) {
    
   });
  //here starts the "get main Household name"
FirebaseFirestore.instance.collection('UsersById')
.doc(FirebaseAuth.instance.currentUser.uid)
.get()
.then((DocumentSnapshot documentSnapshot){
  if(documentSnapshot.exists){
    //this makes the "household" of the current user be streamed!
    print('${documentSnapshot.data()["household"]}' + 'is the snapshot');
    theHousehold='${documentSnapshot.data()["household"]}'.toString().replaceAll(' ', ''); 
  //  theHousehold='second Household';
  }else{
    print('documentSnapshot does not exist');
  }
});
  setzestatus(){
    setState(() {
    });
  }

//new StreamController _streamvariable=StreamController();
    return StreamBuilder<DocumentSnapshot>(

      stream: FirebaseFirestore.instance.collection(haushalte).doc(theHousehold).snapshots(),
      builder:(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        //print (theHousehold);
        
        if(snapshot.hasError){
          return Text('something went wrong');
        }
        if(!snapshot.hasData){
          return Text('snapshot has no data in database');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text('loading');
        }
      //  return Text(snapshot.data.exists.toString());
        Map itemResultMap= Map<String, dynamic>.from(snapshot.data['Items']);
        List titleList=[];
        List dateList=[];
        itemResultMap.forEach((key, value) =>
        titleList.add(ItemsInHousehold.einzeilig(key)));
        itemResultMap.forEach((key, value) =>
        dateList.add(ItemsInHousehold.einzeilig(value)));
      //  return Text(snapshot.data['Items'].toString());
        
        return ListView.builder(itemBuilder: (context, index){
          mainItemSet = titleList[index].toString().replaceAll(',null', '');
          return ListTile(
            title: Text(titleList[index].toString().replaceAll(',null', '')),
            subtitle: Text(dateList[index].toString().replaceAll(',null', '')),
            trailing: IconButton(
              onPressed: (){
              print(titleList[index].toString());
              itemResultMap.remove(titleList[index].toString().replaceAll(',null', ''));
              print(itemResultMap);
              FirebaseFirestore.instance.collection(haushalte).doc(theHousehold).update({
                'Items':itemResultMap
              });
              },
              icon: Icon(Icons.remove_circle_outline_sharp),
              ),
          );
        },
        itemCount: titleList.length,);
      }
      
    );
  }
}
