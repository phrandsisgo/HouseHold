import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class YournameTitle extends StatefulWidget {
  @override
  _YournameTitleState createState() => _YournameTitleState();
}

class _YournameTitleState extends State<YournameTitle> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('UsersById').doc(auth.currentUser.uid).snapshots(),
      builder:(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(snapshot.hasError){
          return Text('snapshot has an Error');
        }
        if(!snapshot.hasData){
          return Text('snapshot has no data in Datenbank');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text('loading');
        }
        Map<String, dynamic> data = snapshot.data.data();
        return  Text ('Hello ${data['Nickname']}');
      }
    );
  }
}