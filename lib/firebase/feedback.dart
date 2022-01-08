import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_app/model/mdUser.dart';
import 'package:plants_app/model/mdfeedback.dart';
import 'package:plants_app/screens/detailsproduct.dart';

class FirFeedback {
  MDFeedback mdFeedback = new MDFeedback();
  final userid = FirebaseFirestore.instance.collection('Users');
  Future<void> addListFeedback(MDFeedback mdFeedback1) async {
    CollectionReference order =
        FirebaseFirestore.instance.collection('Feedback');
    List<MDFeedback> itemList = [];
    MDUser mdUser = new MDUser();
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    final feedbackid = FirebaseFirestore.instance.collection('Feedback');
    await feedbackid.get().then((value) => value.docs.forEach((element) {
          itemList.add(MDFeedback.fromJson(element.data()));
        }));

    List<MDUser> itemListuser = [];
    List<MDUser> itemList1 = [];
    MDUser item = new MDUser();
    await userid
        // .where('idUser', isEqualTo: id)
        .get()
        .then((value) => value.docs.forEach((element) {
              itemListuser.add(MDUser.fromJson(element.data()));
            }));
    itemList1 = itemListuser.where((element) => element.idUser == uid).toList();
    // print(itemList1);
    item = itemList1[0];
    mdFeedback.idKhachHang = uid;
    mdFeedback.anhKhachHang = itemList1[0].image;
    mdFeedback.idSanPham = mdFeedback1.idSanPham;
    mdFeedback.ngay = mdFeedback1.ngay;
    mdFeedback.noiDung = mdFeedback1.noiDung;
    mdFeedback.tenKhachHang = itemList1[0].name;
    mdFeedback.idFeedback = uid + mdFeedback1.idSanPham.toString();
    mdFeedback.state = 'Chờ duyệt';

    order.add({
      'idKhachHang': mdFeedback.idKhachHang,
      'idProduct': mdFeedback.idSanPham,
      'tenKhachHang': mdFeedback.tenKhachHang,
      'anhKhachHang': mdFeedback.anhKhachHang,
      'noiDung': mdFeedback.noiDung,
      'ngay': mdFeedback.ngay,
      'idFeedback': mdFeedback.idFeedback,
      'state': mdFeedback.state
    });
  }

  Future getListFeedback() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    List<MDFeedback> itemList = [];
    final shoppingCartId = FirebaseFirestore.instance
        .collection('Feedback')
        .where('idKhachHang', isEqualTo: uid);

    await shoppingCartId.get().then((value) => value.docs.forEach((element) {
          itemList.add(MDFeedback.fromJson(element.data()));
        }));
    return itemList;
  }

  Future updateNoiDung(String noiDung, String idfeedback) async {
    String? id;

    final shoppingCartId = FirebaseFirestore.instance
        .collection('Feedback')
        .where('idFeedback', isEqualTo: idfeedback);
    await shoppingCartId.get().then((value) => value.docs.forEach((element) {
          id = element.id;
        }));
    // print(shoppingCartId.id);
    FirebaseFirestore.instance
        .collection('Feedback')
        .doc(id)
        .update({'noiDung': noiDung});
  }

  Future getDetailFeedback(String idPro) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    List<MDFeedback> itemList = [];
    final shoppingCartId = FirebaseFirestore.instance
        .collection('Feedback')
        .where('idKhachHang', isEqualTo: uid)
        .where('idProduct', isEqualTo: idPro);
    await shoppingCartId.get().then((value) => value.docs.forEach((element) {
          itemList.add(MDFeedback.fromJson(element.data()));
        }));
    return itemList;
  }

  Future getListFeedbackPro(String id) async {
    List<MDFeedback> itemList = [];
    final shoppingCartId = FirebaseFirestore.instance
        .collection('Feedback')
        .where('idProduct', isEqualTo: id)
        .where('state', isEqualTo: 'Hiển thị');
    await shoppingCartId.get().then((value) => value.docs.forEach((element) {
          itemList.add(MDFeedback.fromJson(element.data()));
        }));
    return itemList;
  }
}
