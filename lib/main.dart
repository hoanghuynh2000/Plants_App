import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:plants_app/screens/contact.dart';
import 'package:plants_app/screens/home.dart';
import 'package:plants_app/screens/listorder.dart';
import 'package:plants_app/screens/login.dart';
import 'package:plants_app/screens/promotionscreen/promotion.dart';


import 'package:plants_app/screens/splash.dart';

void main() {

  runApp(MaterialApp(
    
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('vi')],
      home: Splash()));
}
