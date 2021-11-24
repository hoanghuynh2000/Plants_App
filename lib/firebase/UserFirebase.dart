import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/model/mdUser.dart';

class DataUser {
  final userList = FirebaseFirestore.instance.collection('Users');

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
    return userList.doc(id).update({
      'name': name,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'birthday': birthday,
      'address': address,
      'image': image
    });
  }
}
