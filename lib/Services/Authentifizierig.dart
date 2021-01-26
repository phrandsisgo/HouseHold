import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuehlschrank_app/Models/Users.dart';
import 'package:kuehlschrank_app/Services/Datenbank.dart';

class AuthService {
  String userUid='asd';
//erzeuge ein Benutzer objekt das von FirebaseUser gegeben wird.
  Benutzer _userFromFirebase(User user) {
    return user != null ? Benutzer(uid: user.uid) : null;
  }

//Die Instanz auf der, immer zurückgegriffen wird.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//Authentifikazions Stream das auf Änderungen hört.
  Stream<Benutzer> get user {
    return _firebaseAuth.onAuthStateChanged
        .map((User user) => _userFromFirebase(user));

  }

//sign in Anon ?? maby
  Future anonAnmeldung() async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();
      User user = result.user;
      userUid=user.uid;
      print(user.uid);
      print('above...');
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sing in with email&password
  Future anmeldungMitEmail(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      userUid=user.uid;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register a new Userwith email&passwort
  Future registrierenMitEmail(String email, String password, String nickname) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      //create new doc for every user
      await DatabaseService(uid: user.uid).updateUserData(email, nickname,);
      await DatabaseNicknames(uid: user.uid).updateUserData(email, nickname);
      await ListByEmail(uid: user.uid).updateUserData(email);
      print('should be printet');
      userUid=user.uid;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign out
  Future abmeldung() async {
    try {
      userUid=null;
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
