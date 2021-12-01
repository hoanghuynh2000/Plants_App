import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:plants_app/bloc/authBloc/auth_bloc.dart';
import 'package:plants_app/bloc/authBloc/auth_event.dart';
import 'package:plants_app/bloc/authBloc/auth_state.dart';
import 'package:plants_app/layoutdrawer.dart';
import 'package:plants_app/respository/user_respon.dart';
import 'package:plants_app/screens/login.dart';

import 'package:plants_app/screens/splash.dart';
// @dart=2.9

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UserResponsitory userRepository = UserResponsitory();

  runApp(MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('vi')],
      home: Splash(
        userRepository: userRepository,
      )));
}

class AppParent extends StatelessWidget {
  UserResponsitory? userRepository;
  AppParent({this.userRepository});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc()..add(AppStartedEvent()),
        child: App(
          userRepository: userRepository,
        ));
  }
}

class App extends StatelessWidget {
  UserResponsitory? userRepository;
  App({this.userRepository});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthInitalState) {
        return LoginPageParent(
          userRepository: userRepository,
        );
      } else if (state is AuthenticatedState) {
        return LayoutDrawer(user: state.user, userResponsitory: userRepository);
      } else if (state is UnAuthenticatedState) {
        return LayoutDrawer(
          userResponsitory: userRepository,
        );
      }
      return LayoutDrawer(userResponsitory: userRepository);
    });
  }
}
