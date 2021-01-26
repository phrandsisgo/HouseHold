import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
// collection reference
   CollectionReference brewCollection =

   //wenn eine Registrierung aufgerufen wird
      FirebaseFirestore.instance.collection('UsersById');
  Future updateUserData(String email, String nickname) async {
    return await brewCollection.doc(uid).set({
      'Email': email,
      'Nickname': nickname,
      'Notification':null,
      'uid':uid,
      'household':null,
      'Haushalte':{},
      'Notifcation':[],
    });
  
    }
  

  Stream<QuerySnapshot> get brews{
    return brewCollection.snapshots();
  }
  
}
//add Data muss noch hier sein

class ListByEmail{
  final String uid;
  String email;
  ListByEmail({this.uid});
  Future updateUserData(String email)async{
    return await FirebaseFirestore.instance.collection('UsersByEmail').doc(email).set({
      'uid':uid,
      'email':email
    });
  }
}

class DatabaseNicknames{
  final String uid;
  String nickname;
  String email;
    DatabaseNicknames({this.uid});
  Future updateUserData(String email, String nickname,)async{
      return await FirebaseFirestore.instance.collection('nicknames').doc(nickname).set({
      'Email': email,
      'Nickname': nickname,
      'uid':uid,
      'mainhousehold': 'keine',
      'Haushalte':'noch keine verfügbar'
        
      });
}
}


class Fridges{
   String fridgename;
   CollectionReference fridgeReference= FirebaseFirestore.instance.collection('Haushalte');
   Fridges({this.fridgename});
   Future newFridge(String haushaltsName,String uid)async{
     print('Fridges called');
     return await FirebaseFirestore.instance.collection('Haushalte').doc(haushaltsName).set({
       'Haushalts Name':haushaltsName,
       'Creator id': uid,
     });
   }
}

class Something{

  
  final FirebaseAuth auth = FirebaseAuth.instance;
  DocumentReference mainHousehold= FirebaseFirestore.instance.collection('UsersById').doc(FirebaseAuth.instance.currentUser.uid.toString());
  //funktion um den Snapshot darzustellen
  String whateverso='something';
  
  Stream <DocumentSnapshot> get haupthaushalt{
    
  }
}