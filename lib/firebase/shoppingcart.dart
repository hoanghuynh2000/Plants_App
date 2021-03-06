import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/model/mddetailorder.dart';
import 'package:plants_app/model/mddetailshoppingcart.dart';
class FirShoppingCart{
  MDDetailShoppingCart mdDetailShoppingCart = new MDDetailShoppingCart();
    Future<void> addToShoppingCart(String idKhachHang, String idPro,String namePro,String price,String category,String image,) async {
       FirebaseAuth auth=FirebaseAuth.instance;
     String uid= auth.currentUser!.uid.toString();
    CollectionReference shoppingCart = FirebaseFirestore.instance.collection('ShoppingCart');
    List<MDDetailShoppingCart>itemList=[];
      final shoppingCartId= FirebaseFirestore.instance.collection('ShoppingCart').where('idProduct',isEqualTo: idPro);
    await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {itemList.add(MDDetailShoppingCart.fromJson({
         mdDetailShoppingCart.idKhachHang: "idKhachHang",
       mdDetailShoppingCart.quantity:['quantity'],
       mdDetailShoppingCart.idProduct:['idProduct'],
       mdDetailShoppingCart.productName:['productName'],
       mdDetailShoppingCart.categoryName:['categoryName'],
       mdDetailShoppingCart.price:['price'],
       mdDetailShoppingCart.images:['images']}
        ));}));
         List<MDDetailShoppingCart>cusList=[];
         
      final cus= FirebaseFirestore.instance.collection('ShoppingCart').where('idKhachHang',isEqualTo: idKhachHang);
    await cus.get().then((value) => value.docs.forEach(
        (element) {cusList.add(MDDetailShoppingCart.fromJson(element.data()
      //    mdDetailShoppingCart.idKhachHang: "idKhachHang",
      //  mdDetailShoppingCart.quantity:['quantity'],
      //  mdDetailShoppingCart.idProduct:['idProduct'],
      //  mdDetailShoppingCart.productName:['productName'],
      //  mdDetailShoppingCart.categoryName:['categoryName'],
      //  mdDetailShoppingCart.price:['price'],
      //  mdDetailShoppingCart.images:['images']}
        ));}));
        
         List<MDDetailShoppingCart>KHList=cusList.where((element) => element.idProduct==idPro).toList();
    if(uid.isNotEmpty){
      if(KHList.length==0){
    mdDetailShoppingCart.idKhachHang=idKhachHang;
    mdDetailShoppingCart.idProduct=idPro;
    mdDetailShoppingCart.productName=namePro;
    mdDetailShoppingCart.price=price;
    mdDetailShoppingCart.categoryName=category;
    mdDetailShoppingCart.images=image;
    mdDetailShoppingCart.quantity='1';
    shoppingCart.add({
        'idKhachHang': mdDetailShoppingCart.idKhachHang,
      'idProduct':mdDetailShoppingCart.idProduct,
      'productName': mdDetailShoppingCart.productName,
      'categoryName': mdDetailShoppingCart.categoryName,
      'price':mdDetailShoppingCart.price,
      'images':mdDetailShoppingCart.images,
      'quantity':mdDetailShoppingCart.quantity
    });
    
     }else{
     SnackBar(content: Text('S???n Ph???m ???? c?? trong gi??? h??ng'),);
     }
    }
    else {
      SnackBar(content: Text('Vui l??ng ????ng nh???p'));
    }
  }
   Future getListShoppingCart(String id) async {
      List<MDDetailShoppingCart>itemList=[];
      final shoppingCartId= FirebaseFirestore.instance.collection('ShoppingCart').where('idKhachHang',isEqualTo: id);
       await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {itemList.add(MDDetailShoppingCart.fromJson(element.data()
     
        ));}));
        return itemList;
   }
   Future updateProduct(String idPro, String quantity) async {
     String? id;
    final shoppingCartId= FirebaseFirestore.instance.collection('ShoppingCart').where('idProduct',isEqualTo: idPro);
    await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {id=element.id;}));
      // print(shoppingCartId.id);
      final deshoppingCartId= FirebaseFirestore.instance.collection('ShoppingCart').doc(id).update({'quantity':quantity});
   }
   Future removeProduct(String idPro) async {
     String? id;
      FirebaseAuth auth=FirebaseAuth.instance;
     String uid= auth.currentUser!.uid.toString();
    final shoppingCartId= FirebaseFirestore.instance.collection('ShoppingCart').where('idProduct',isEqualTo: idPro);
    shoppingCartId.where('idKhachHang',isEqualTo: uid);
    await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {id=element.id;}));
      // print(shoppingCartId.id);
      final deshoppingCartId= FirebaseFirestore.instance.collection('ShoppingCart').doc(id).delete();
   }
   Future removeProductorder() async {
     String? id;
     FirebaseAuth auth=FirebaseAuth.instance;
     String uid= auth.currentUser!.uid.toString();
     List<MDDetailShoppingCart>itemList=[];
    final shoppingCartId= FirebaseFirestore.instance.collection('ShoppingCart').where('idKhachHang',isEqualTo: uid);
    
    await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {itemList.add(MDDetailShoppingCart.fromJson(element.data()
     
        ));}));
        for(int i=0;i<itemList.length;i++){
  await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {id=element.id;}));
      // print(shoppingCartId.id);
      final deshoppingCartId= FirebaseFirestore.instance.collection('ShoppingCart').doc(id).delete();
        }
        
  
   }
}