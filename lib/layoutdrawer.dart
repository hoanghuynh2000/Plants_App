import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_bloc.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_event.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_state.dart';
import 'package:plants_app/respository/user_respon.dart';
import 'package:plants_app/screens/dashboard.dart';
import 'package:plants_app/screens/drawer.dart';
import 'package:plants_app/screens/login.dart';

class LayoutDrawer extends StatefulWidget {
  User? user;
  UserResponsitory? userResponsitory;
  LayoutDrawer({this.user, this.userResponsitory});
  @override
  _LayoutDrawerState createState() => _LayoutDrawerState();
}

class _LayoutDrawerState extends State<LayoutDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Duration duration = Duration(milliseconds: 400);
  User? user;
  FetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration);

    super.initState();
    FetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            DrawerBloc(userResponsitory: widget.userResponsitory),
        child: Scaffold(
          body: Stack(
            children: [
              DrawerParent(
                user: user,
                userResponsitory: widget.userResponsitory,
              ),
              Dashboard()
            ],
          ),
        ));
  }
}
