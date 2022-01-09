import 'package:cloud_firestore/cloud_firestore.dart';

class mdOrder {
  String? idOrder;
  String? nameCus;
  String? idCus;
  String? phoneCus;
  String? addressCus;
  String? state;
  String? date;
  dynamic dateDelivery;
  String? promotion;
  String? payment;
  String? point;
  String? quantity;
  String? totalPayment;
  String? statePayment;
  String? costShip;
  String? totalPrice;
  mdOrder(
      {this.idCus,
      this.addressCus,
      this.nameCus,
      this.phoneCus,
      this.idOrder,
      this.point,
      this.totalPrice,
      this.state,
      this.promotion,
      this.date,
      this.payment,
      this.statePayment,
      this.costShip,
      this.totalPayment,
      this.quantity,
      this.dateDelivery});
  Map<String, dynamic> toMap() {
    return {
      'idCus': idCus,
      'namecus': nameCus,
      'phoneCus': phoneCus,
      'addressCus': addressCus,
      'idOrder': idOrder,
      'state': state,
      'date': date,
      'Promotion': promotion,
      'payment': payment,
      'quantity': quantity,
      'totalPayment': totalPayment,
      'statePayment': state,
      'costShip': costShip,
      'dateDelivery': dateDelivery,
      'totalPrice': totalPrice,
      'point': point
    };
  }

  factory mdOrder.fromJson(Map<String, dynamic> res) {
    return mdOrder(
        idCus: res['idCus'],
        nameCus: res["nameCus"],
        addressCus: res['addressCus'],
        phoneCus: res['phoneCus'],
        quantity: res['quantity'],
        idOrder: res['idOrder'],
        state: res['state'],
        statePayment: res['statePayment'],
        totalPayment: res['totalPayment'],
        promotion: res['Promotion'],
        date: res['date'],
        dateDelivery: res['dateDelivery'],
        costShip: res['costShip'],
        payment: res['payment'],
        totalPrice: res['totalPrice'],
        point: res['point']);
  }
}
