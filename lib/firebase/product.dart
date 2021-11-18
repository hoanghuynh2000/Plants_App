import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_app/model/mdcategory.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/model/mdpromotion.dart';
class DataProduct{
  final categorylist= FirebaseFirestore.instance.collection('categories');
  final productList= FirebaseFirestore.instance.collection('products');
  Future getAllCategory()async{
   // categorylist.where('MaLoai',isEqualTo: id);
    await Firebase.initializeApp();
    List<Category>listCategory=[];
     await categorylist.get().then((value) => value.docs.forEach(
        (element) {listCategory.add(Category.fromJson(element.data()));}));
        
        return listCategory;
  }
   Future getAllProductList()async{
     await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<DetailProduct> itemList=[];
    
      await productList.get().then((value) => value.docs.forEach(
        (element) {itemList.add(DetailProduct.fromJson(element.data()));}));
        
        return itemList;
        
    

   }
}