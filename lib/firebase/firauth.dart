import 'package:firebase_auth/firebase_auth.dart';
class FirAuth{
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  void register(String name, String phone, String password,String email){
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }
}