import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_app/model/mdUser.dart';
import 'package:plants_app/model/mdnotification.dart';
import 'package:plants_app/screens/detailsproduct.dart';

class FirNotification {
  MDNotification mdNotification = new MDNotification();
  final userid = FirebaseFirestore.instance.collection('Notification');
  Future<void> addListNoti(String info, String date) async {
    CollectionReference order =
        FirebaseFirestore.instance.collection('Notification');
    List<MDNotification> itemList = [];
    MDUser mdUser = new MDUser();
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    final feedbackid = FirebaseFirestore.instance.collection('Notification');
    await feedbackid.get().then((value) => value.docs.forEach((element) {
          itemList.add(MDNotification.fromJson(element.data()));
        }));

    mdNotification.id = uid + date.toString();
    mdNotification.idCus = uid;
    mdNotification.dateNoti = date.toString();
    mdNotification.infoNoti = info;

    order.add({
      'id': mdNotification.id,
      'idCus': mdNotification.idCus,
      'dateNoti': mdNotification.dateNoti,
      'infoNoti': mdNotification.infoNoti,
    });
  }

  Future getListNoti() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    List<MDNotification> itemList = [];
    final noti = FirebaseFirestore.instance
        .collection('Notification')
        .where('idCus', isEqualTo: uid);
    await noti.get().then((value) => value.docs.forEach((element) {
          itemList.add(MDNotification.fromJson(element.data()));
        }));
    return itemList;
  }
}
