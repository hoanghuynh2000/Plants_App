import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:plants_app/model/mdnews.dart';

class FirNews{
  final newList= FirebaseFirestore.instance.collection('news');
  Future getListNews()async{
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
     List<MDNews> itemList=[];
    
      await newList.get().then((value) => value.docs.forEach(
        (element) {itemList.add(MDNews.fromJson(element.data()));}));
        
        return itemList;
    
      }
}