import 'dart:async';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plants_app/layoutdrawer.dart';
import 'package:plants_app/screens/dashboard.dart';
import 'package:plants_app/screens/drawer.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 6000), () {
      Navigator.of(context).push(
        PageTransition(
            type: PageTransitionType.rightToLeft, child: LayoutDrawer()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      //backgroundColor: Colors.teal.shade500,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/images/backgroundsplash.jpg',
                  fit: BoxFit.cover)),
          Container(
              width: double.infinity,
              child: Column(
                children: [
                  Spacer(),
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _buildAnimateLogo(size),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          _buildAnimateName(size)
                        ],
                      ))
                ],
              ))
        ],
      ),
    ));
  }

  Widget _buildAnimateLogo(Size size) {
    return Container(
      child: Animator(
          tweenMap: {
            'opacity': Tween<double>(begin: 0, end: 1),
            'scale': Tween<double>(begin: 10, end: 1)
          },
          cycles: 1,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 3000),
          // endAnimationListener: (amin) {
          //   setState(() {

          //   });
          // },
          builder: (_, amin, __) => FadeTransition(
                opacity: amin.getAnimation('opacity'),
                child: Transform.scale(
                  scale: amin.getValue('scale'),
                  child: Container(
                    width: size.width * 0.8,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              )),
    );
  }

  Widget _buildAnimateName(Size size) {
    return Container(
      child: Animator(
          tweenMap: {
            'opacity': Tween<double>(begin: 0, end: 1),
            'motion': Tween<double>(begin: 10, end: 1)
          },
          cycles: 1,
          curve: Curves.easeInOutCubic,
          duration: Duration(milliseconds: 2300),
          // endAnimationListener: (amin) {
          //   setState(() {

          //   });
          // },
          builder: (_, amin, __) => FadeTransition(
                opacity: amin.getAnimation('opacity'),
                child: Transform.scale(
                    scale: amin.getValue('motion'),
                    child: Text(
                      'Plants',
                      style: TextStyle(
                          color: Colors.teal.shade900,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ephesis'),
                    )),
              )),
    );
  }
}
