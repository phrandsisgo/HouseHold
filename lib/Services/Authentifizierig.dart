import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuehlschrank_app/Models/Users.dart';
import 'package:kuehlschrank_app/Services/Datenbank.dart';

class AuthService {
//erzeuge ein Benutzer objekt das von FirebaseUser gegeben wird.
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

//Die Instanz auf der, immer zurückgegriffen wird.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//Authentifikazions Stream das auf Änderungen hört.
  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebase(user));
  }

//sign in Anon ?? maby
  Future anonAnmeldung() async {
    try {
      AuthResult result = await _firebaseAuth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sing in with email&password
  Future anmeldungMitEmail(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email&passwort
  Future registrierenMitEmail(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //create new doc for every user
      await DatabaseService(uid: user.uid)
          .updateUserData('0', "Francisco", 100);
      print('should be printet');
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign out
  Future abmeldung() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
