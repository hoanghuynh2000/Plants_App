import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:plants_app/model/mdUser.dart';

class UserResponsitory {
  FirebaseAuth? firebaseAuth;
  FirebaseFirestore? firebaseFirestore;
  UserResponsitory() {
    this.firebaseAuth = FirebaseAuth.instance;
  }
  Future<User?> CreateUser(String email, String password) async {
    try {
      var result = await firebaseAuth!
          .createUserWithEmailAndPassword(email: email, password: password);

      return result.user;
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> SignInUser(String email, String password) async {
    var result = await firebaseAuth!
        .signInWithEmailAndPassword(email: email, password: password);

    return result.user;
  }

  Future<void> userSetup(String displayName, String phoneNumber) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    MDUser? mdUser = new MDUser();
    mdUser.email = auth.currentUser!.email;
    mdUser.name = displayName;
    mdUser.point = 0;
    mdUser.birthday = null;
    mdUser.gender = 'Nam';
    mdUser.phoneNumber = phoneNumber;
    mdUser.idUser = auth.currentUser!.uid;
    mdUser.image = null;

    users.add({
      'name': mdUser.name,
      'email': mdUser.email,
      'idUser': mdUser.idUser,
      'gender': mdUser.gender,
      'phoneNumber': phoneNumber,
      'birthday': mdUser.birthday,
      'address': mdUser.address,
      'point': mdUser.point,
      'image': mdUser.image
    });
  }

  Future<void> SignOut() async {
    firebaseAuth!.signOut();
  }

  Future<bool> IsSignIn() async {
    var currentUser = await firebaseAuth!.currentUser;
    return currentUser != null;
  }

  Future<User> getCurrentUser() async {
    return await firebaseAuth!.currentUser!;
  }
}
