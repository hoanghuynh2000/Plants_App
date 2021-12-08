import 'package:flutter/widgets.dart';

class MDFeedback {
  String? idFeedback;
  String? state;
  String? idSanPham;
  String? idKhachHang;
  String? tenKhachHang = '......';
  String? anhKhachHang;
  String? noiDung = '.......................';
  String? ngay;

  MDFeedback(
      {this.idSanPham,
      this.tenKhachHang,
      this.anhKhachHang,
      this.noiDung,
      this.ngay,
      this.idKhachHang,
      this.idFeedback,
      this.state});
  Map<String, dynamic> toMap() {
    return {
      'idKhachHang': idKhachHang,
      'idProduct': idSanPham,
      'tenKhachHang': tenKhachHang,
      'anhKhachHang': anhKhachHang,
      'noiDung': noiDung,
      'ngay': ngay,
      'idFeedback': idFeedback,
      'state': state
    };
  }

  factory MDFeedback.fromJson(Map<String, dynamic> res) {
    return MDFeedback(
        idKhachHang: res["idKhachHang"],
        idSanPham: res['idProduct'],
        tenKhachHang: res['tenKhachHang'],
        anhKhachHang: res['anhKhachHang'],
        noiDung: res['noiDung'],
        ngay: res['ngay'],
        idFeedback: res['idFeedback'],
        state: res['state']);
  }
}
