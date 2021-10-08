import 'package:flutter/material.dart';
import 'package:plants_app/screens/classbuilder.dart';
import 'package:plants_app/screens/splash.dart';

void main() {
  ClassBuilder.registerClasses();
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: Splash(),
  ));
}
