import 'package:cloud_firestore/cloud_firestore.dart';

class MDNotification {
  String? id;
  String? infoNoti;
  String? dateNoti;
  String? idCus;
  MDNotification({this.id, this.infoNoti, this.dateNoti, this.idCus});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'infoNoti': infoNoti,
      'dateNoti': dateNoti,
      'idCus': idCus,
    };
  }

  factory MDNotification.fromJson(Map<String, dynamic> res) {
    return MDNotification(
        id: res['id'],
        idCus: res['idCus'],
        dateNoti: res['dateNoti'],
        infoNoti: res['infoNoti']);
  }
}
