import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/model/mdUser.dart';
import 'package:plants_app/model/mdorder.dart';

class FirListOder{
  mdOrder mdorder = new mdOrder();
    Future<void> addListOrder(String idCus, String nameCus,String phoneCus,String addressCus,String idOrder,String state,String date,String dateDelivery,String promotion,String point, 
    String payment,String quantity,String totalPayment,String statepayment,String costShip,String totalPrice) async {
    CollectionReference order = FirebaseFirestore.instance.collection('Orders');
    List<mdOrder>itemList=[];
      final oderId= FirebaseFirestore.instance.collection('Orders');
    await oderId.get().then((value) => value.docs.forEach(
        (element) {itemList.add(mdOrder.fromJson(
            element.data()
        
        ));}));
         
         
   
         List<mdOrder>listOrder=[];
    mdorder.idCus=idCus;
    mdorder.nameCus=nameCus;
    mdorder.addressCus=addressCus;
    mdorder.phoneCus=phoneCus;
    mdorder.idOrder=idOrder;
    mdorder.state=state;
    mdorder.date=date;
    mdorder.dateDelivery=dateDelivery;
    mdorder.costShip=costShip;
    mdorder.payment=payment;
    mdorder.promotion=promotion;
    mdorder.point=point;
    mdorder.totalPayment=totalPayment;
    mdorder.totalPrice=totalPrice;
    mdorder.statePayment=statepayment;
    mdorder.quantity=quantity;

    order.add({
      'idCus':mdorder.idCus,
       'nameCus':mdorder.nameCus,
       'addressCus':mdorder.addressCus,
       'phoneCus': mdorder.phoneCus,
      'idOrder': mdorder.idOrder,
      'state':  mdorder.state,
      'date':  mdorder.date,
      'Promotion': mdorder.promotion,
      'payment': mdorder.payment,
      'quantity': mdorder.quantity,
      'totalPayment': mdorder.totalPayment,
      'statePayment': mdorder.statePayment,
      'costShip': mdorder.costShip,
      'dateDelivery': mdorder.dateDelivery,
      'totalPrice': mdorder.totalPrice,
      'point': mdorder.point
    });
    
    
    }
   Future getListOrderid(String id) async {
      List<mdOrder>itemList=[];
      final shoppingCartId= FirebaseFirestore.instance.collection('Orders').where('idOrder',isEqualTo: id);
       await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {itemList.add(mdOrder.fromJson(element.data()
    
      
        ));}));
        return itemList;
   }
   Future getListOrder(String id) async {
      List<mdOrder>itemList=[];
      final shoppingCartId= FirebaseFirestore.instance.collection('Orders').where('idCus',isEqualTo: id);
       await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {itemList.add(mdOrder.fromJson(element.data()
    
      
        ));}));
        return itemList;
   }
   Future getUser() async {
      FirebaseAuth auth=FirebaseAuth.instance;
      MDUser mdUser=new MDUser();
     String uid= auth.currentUser!.uid.toString();
      List<MDUser>itemList=[];
      final shoppingCartId= FirebaseFirestore.instance.collection('Users').where('idUser',isEqualTo: uid);
       await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {itemList.add(MDUser.fromJson(element.data()));}));
        return itemList;
   }
  Future updateDiem(String diem) async {
     String? id;
    FirebaseAuth auth=FirebaseAuth.instance;
     String uid= auth.currentUser!.uid.toString();
    final shoppingCartId= FirebaseFirestore.instance.collection('Users').where('idUser',isEqualTo: uid);
    await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {id=element.id;}));
      // print(shoppingCartId.id);
      FirebaseFirestore.instance.collection('Users').doc(id).update({'point':diem});
   }
   Future updateAddress(String idOrder,String name,String phone, String address) async {
     String? id;
    FirebaseAuth auth=FirebaseAuth.instance;
     String uid= auth.currentUser!.uid.toString();
     final shoppingCartId= FirebaseFirestore.instance.collection('Orders').where('idOrder',isEqualTo: idOrder);
    await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {id=element.id;}));
      FirebaseFirestore.instance.collection('Orders').doc(id).update({'nameCus':name,'phoneCus':phone,'addressCus':address});
   }
   Future removeProduct(String idOder) async {
     String? id;
    final shoppingCartId= FirebaseFirestore.instance.collection('Orders').where('idOrder',isEqualTo: idOder);
    await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {id=element.id;}));
      // print(shoppingCartId.id);
      final deshoppingCartId= FirebaseFirestore.instance.collection('Oders').doc(id).delete();
   }
}