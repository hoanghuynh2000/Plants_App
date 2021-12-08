import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/model/mddetailorder.dart';

class FirListDetailOrder{
  mdDetailOrder mddetailorder = new mdDetailOrder();
    Future<void> addListDetailOrder(String idKhachHang,String quantity,String price,String idOrder,String idPro,String imagePro, String namePro ) async {
    CollectionReference order = FirebaseFirestore.instance.collection('DetailOrders');
    List<mdDetailOrder>itemList=[];
      final oderId= FirebaseFirestore.instance.collection('DetailOrders');
    await oderId.get().then((value) => value.docs.forEach(
        (element) {itemList.add(mdDetailOrder.fromJson(
            element.data()
        
        ));}));
    mddetailorder.namePro=namePro;
    mddetailorder.imagePro=imagePro;
    mddetailorder.idKhachHang=idKhachHang;
    mddetailorder.idOrder=idOrder;
    mddetailorder.idPro=idPro;
    mddetailorder.quantity=quantity;
    mddetailorder.price=price;
    mddetailorder.state='Chưa đánh giá';

    order.add({
      'namePro':mddetailorder.namePro,
      'imagePro':mddetailorder.imagePro,
        'idKhachHang':mddetailorder.idKhachHang,
      'quantity':mddetailorder.quantity,
      'totalPrice':mddetailorder.price,
      'idOrder':mddetailorder.idOrder,
      'idPro':mddetailorder.idPro,
      'state':mddetailorder.state
    });
    
    
    }
  
   Future getListDetailOrder() async {
      List<mdDetailOrder>itemList=[];
      final shoppingCartId= FirebaseFirestore.instance.collection('DetailOrders');
       await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {itemList.add(mdDetailOrder.fromJson(element.data()
    
      
        ));}));
        return itemList;
   }
   Future updateOrder(String idPro) async {
     String? id;
     String state='Đã hủy';
    final shoppingCartId= FirebaseFirestore.instance.collection('Orders').where('idOrder',isEqualTo: idPro);
    await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {id=element.id;}));
      // print(shoppingCartId.id);
      FirebaseFirestore.instance.collection('Orders').doc(id).update({'state':state});
   }
    Future updateStateDetailOrder(String idOrder, String idPro) async {
     String? id;
     String state='Đã đánh giá';
    final shoppingCartId= FirebaseFirestore.instance.collection('DetailOrders').where('idOrder',isEqualTo: idOrder  ).where('idPro',isEqualTo: idPro);
    await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {id=element.id;}));
      // print(shoppingCartId.id);
      FirebaseFirestore.instance.collection('DetailOrders').doc(id).update({'state':state});
   }
   Future removeProduct(String idOder) async {
     String? id;
    final shoppingCartId= FirebaseFirestore.instance.collection('DetailOrders').where('idOrder',isEqualTo: idOder);
    await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {id=element.id;}));
      // print(shoppingCartId.id);
      final deshoppingCartId= FirebaseFirestore.instance.collection('DetailOrders').doc(id).delete();
   }
}