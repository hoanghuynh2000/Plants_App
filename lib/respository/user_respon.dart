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

  Future<void> ResetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> SignInUser(String email, String password) async {
    var errorMessage = "Tài khoản không tồn tại";
    try {
      var result = await firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);

      return result.user;
    } on PlatformException catch (e) {
      print(e.code);

      throw Exception(e.code);
    }
  }

  Future<void> userSetup(String displayName, String phoneNumber) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    MDUser? mdUser = new MDUser();
    mdUser.email = auth.currentUser!.email;
    mdUser.name = displayName;
    mdUser.point = 0;
    mdUser.birthday = '01/01/1900';
    mdUser.address = 'Thành Phố Hồ Chí Minh';
    mdUser.gender = 'Nam';
    mdUser.phoneNumber = phoneNumber;
    mdUser.idUser = auth.currentUser!.uid;
    mdUser.image =
        'https://firebasestorage.googleapis.com/v0/b/appplants-fbbf8.appspot.com/o/images%2FUser.jpg?alt=media&token=589ffca4-813a-4b93-bf86-841ed2e020cc';

    users.doc(mdUser.idUser).set({
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
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> IsSignIn() async {
    var currentUser = await firebaseAuth!.currentUser;
    return currentUser != null;
  }

  Future<User> getCurrentUser() async {
    return await firebaseAuth!.currentUser!;
  }

  Future<bool> validatePassword(String password) async {
    User? firebaseUser = await firebaseAuth!.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser!.email!, password: password);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    var firebaseUser = await firebaseAuth!.currentUser;
    firebaseUser!.updatePassword(password);
  }
}
