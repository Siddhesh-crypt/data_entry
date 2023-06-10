import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signupWithEmailAndPassword(String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signinWithEmailAndPassword(String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}