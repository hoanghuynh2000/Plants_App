import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/model/mddetailorder.dart';
import 'package:plants_app/model/mddetailshoppingcart.dart';
class FirShoppingCart{
  MDDetailShoppingCart mdDetailShoppingCart = new MDDetailShoppingCart();
    Future<void> addToShoppingCart(String idKhachHang, String idPro,String namePro,String price,String category,String image,) async {
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
    if(idKhachHang.isNotEmpty){
      if(itemList.isEmpty){
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
    
     SnackBar(content: Text('Thêm vào giỏ hàng thành công'),);
     }
     SnackBar(content: Text('Sản Phẩm đã có trong giỏ hàng'),);
    }
    else {
      SnackBar(content: Text('Vui lòng đăng nhập'));
    }
  }
   Future getListShoppingCart(String id) async {
      List<MDDetailShoppingCart>itemList=[];
      final shoppingCartId= FirebaseFirestore.instance.collection('ShoppingCart').where('idKhachHang',isEqualTo: id);
       await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {itemList.add(MDDetailShoppingCart.fromJson(element.data()
      //    mdDetailShoppingCart.idKhachHang: "idKhachHang",
      //  mdDetailShoppingCart.quantity:['quantity'],
      //  mdDetailShoppingCart.idProduct:['idProduct'],
      //  mdDetailShoppingCart.productName:['productName'],
      //  mdDetailShoppingCart.categoryName:['categoryName'],
      //  mdDetailShoppingCart.price:['price'],
      //  mdDetailShoppingCart.images:['images']
      
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
    final shoppingCartId= FirebaseFirestore.instance.collection('ShoppingCart').where('idProduct',isEqualTo: idPro);
    await shoppingCartId.get().then((value) => value.docs.forEach(
        (element) {id=element.id;}));
      // print(shoppingCartId.id);
      final deshoppingCartId= FirebaseFirestore.instance.collection('ShoppingCart').doc(id).delete();
   }
}