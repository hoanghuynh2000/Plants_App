import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_app/model/mdpromotion.dart';
class DataPromotion{
  final promotionList= FirebaseFirestore.instance.collection('discounts').where('TinhTrangKhuyenMai',isEqualTo: "Còn hạn");

   Future getPromotionList()async{
     await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<MDPromotion> itemList=[];
    
      await promotionList.get().then((value) => value.docs.forEach(
        (element) {itemList.add(MDPromotion.fromJson(element.data()));}));
        
        return itemList;
    

   }
}