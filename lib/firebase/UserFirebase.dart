import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/model/mdUser.dart';

class DataUser {
  final userList = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future getUserList(String id) async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<MDUser> itemList = [];
    List<MDUser> itemList1 = [];
    MDUser item = new MDUser();
    await userList
        // .where('idUser', isEqualTo: id)
        .get()
        .then((value) => value.docs.forEach((element) {
              itemList.add(MDUser.fromJson(element.data()));
            }));
    itemList1 = itemList.where((element) => element.idUser == id).toList();
    // print(itemList1);
    item = itemList1[0];
    return item;
  }

  Future UpdateUser(
    String id,
    String name,
    String gender,
    String birthday,
    String phoneNumber,
    String address,
    String image,
  ) async {
    return await userList.doc(id).update({
      'name': name,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'birthday': birthday,
      'address': address,
      'image': image
    });
  }

  Future _changePassword(String password) async {
//Create an instance of the current user.
    User? user = await firebaseAuth.currentUser;

//Pass in the password to updatePassword.
    user!.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  Future<bool> validatePassword(String password) async {
    User? firebaseUser = await firebaseAuth.currentUser;

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
    var firebaseUser = await firebaseAuth.currentUser;
    firebaseUser!.updatePassword(password);
  }
}
