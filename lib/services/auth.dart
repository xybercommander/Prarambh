import 'package:firebase_auth/firebase_auth.dart';
import 'package:prarambh/modules/profile.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Instance for user
  UserProfile _userFromFirebaseUser(User user) {
    return user != null ? UserProfile(userId: user.uid) : null;
  }


  // Sign in method
  signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
    }
  }


  // Signup Method
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
    }
  }


  // Reset Password Method
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e) {
      print(e.toString());
    }
  }


  // Signout Method
  Future signOut() async {
    try {
      return _auth.signOut();
    }catch(e){
      print(e.toString());
    } 
  }
}