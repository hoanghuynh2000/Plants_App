import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/model/mdAddress.dart';

class AddressFirebase {
  CollectionReference users =
      FirebaseFirestore.instance.collection('AddressDelivery');

  Future<void> AddAddress(
      String name, String phoneNumber, String street, String address) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    DateTime now = DateTime.now();
    String id = DateFormat('yyyyMMddhhmmss').format(now);
    users.doc(id + uid).set({
      'idAddress': id + uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'street': street,
      'idCus': uid
    });
  }

  Future getAddressList() async {
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<MDAddress> itemList = [];
    List<MDAddress> itemList1 = [];

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    await users
        .where('idCus', isEqualTo: uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              itemList.add(MDAddress.fromJson(element.data()));
            }));
    itemList1 = itemList.where((element) => element.idCus == uid).toList();
    print(itemList1);

    return itemList;
  }

  Future<void> DeleteAddress(String idAddress) async {
    final shoppingCartId = FirebaseFirestore.instance
        .collection('AddressDelivery')
        .where('idAddress', isEqualTo: idAddress);
    await shoppingCartId.get().then((value) => value.docs.forEach((element) {
          idAddress = element.id;
        }));
    // print(shoppingCartId.id);
    final deshoppingCartId = FirebaseFirestore.instance
        .collection('AddressDelivery')
        .doc(idAddress)
        .delete();
  }
}
