import 'package:flutter/material.dart';
import 'package:plants_app/screens/dashboard.dart';
import 'package:plants_app/screens/drawer.dart';

class LayoutDrawer extends StatefulWidget {
  LayoutDrawer({Key? key}) : super(key: key);

  @override
  _LayoutDrawerState createState() => _LayoutDrawerState();
}

class _LayoutDrawerState extends State<LayoutDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Duration duration = Duration(milliseconds: 400);
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [MainWidget(), Dashboard()],
      ),
    );
  }
}
