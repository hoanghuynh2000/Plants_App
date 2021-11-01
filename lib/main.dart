import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:plants_app/screens/listorder.dart';

import 'package:plants_app/screens/splash.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.

        primaryColor: Colors.teal[800],
      ),
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('vi')],
      home: Splash()));
}
