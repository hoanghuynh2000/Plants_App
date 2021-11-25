import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_app/model/mdnews.dart';
import 'package:plants_app/model/mdpromotion.dart';
class FirNews{
  final newslist= FirebaseFirestore.instance.collection('news');

   Future getListNews()async{
     await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    List<MDNews> itemList=[];
    
      await newslist.get().then((value) => value.docs.forEach(
        (element) {itemList.add(MDNews.fromJson(element.data()));}));
        
        return itemList;
    

   }
}