import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MDPromotion {
  String? id;
  String? namePromo;
  String? discount;
  String? discountMax;
  Timestamp? dateStart;
  Timestamp? dateEnd;
  String? state;
  MDPromotion(
      {this.id,
      this.namePromo,
      this.discount,
      this.discountMax,
      this.dateStart,
      this.dateEnd,
      this.state});
factory MDPromotion.fromJson(Map<String,dynamic>json){
  return MDPromotion(
    id: json['MaKhuyenMai'],
    namePromo: json['TenKhuyenMai'],
    discount:json['ChietKhau'],
    discountMax: json['KhuyenMaiToiDa'],
    dateStart: json['NgayKhuyenMai'][0],
    dateEnd: json['NgayKhuyenMai'][1],
    state: json['TinhTrangKhuyenMai'],
  );
}

}
