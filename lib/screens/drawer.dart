import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_bloc.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_event.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_state.dart';
import 'package:plants_app/firebase/UserFirebase.dart';
import 'package:plants_app/model/mdUser.dart';
import 'package:plants_app/respository/user_respon.dart';
import 'package:plants_app/screens/contact.dart';
import 'package:plants_app/screens/dashboard.dart';
import 'package:plants_app/screens/favorites.dart';
import 'package:plants_app/screens/listorder.dart';
import 'package:plants_app/screens/login.dart';
import 'package:plants_app/screens/profile/profile.dart';
import 'package:plants_app/screens/register.dart';
import 'package:plants_app/screens/rules.dart';

class DrawerParent extends StatelessWidget {
  User? user;
  UserResponsitory? userResponsitory;
  DrawerParent({this.user, this.userResponsitory});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return DrawerBloc(userResponsitory: userResponsitory);
        },
        child: MainWidget(
          userResponsitory: userResponsitory,
          user: user,
        ));
  }
}

class MainWidget extends StatefulWidget {
  User? user;
  UserResponsitory? userResponsitory;
  MainWidget({this.user, this.userResponsitory});
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  DrawerBloc? homePageBloc;
  MDUser? itemuser;
  var list;
  var random;

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = List.generate(3, (i) => "Item $i");
    super.initState();
    random = Random();
    refreshList();
    if (widget.user != null) {
      FetchData();
    }
  }

  String? image;

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    if (this.mounted)
      setState(() {
        list = List.generate(random.nextInt(10), (i) => "Item $i");
      });

    return null;
  }

  FetchImage() async {
    final ref = FirebaseStorage.instance.ref().child('${itemuser!.image}');
    image = await itemuser!.image;
  }

  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await DataUser().getUserList(widget.user!.uid);
    if (result == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          itemuser = result;
          FetchImage();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    homePageBloc = BlocProvider.of<DrawerBloc>(context);
    if (widget.user != null) {
      FetchData();
    }
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: Container(
                height: size.height,
                child: SingleChildScrollView(
                    child: Container(
                        height: size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.topRight,
                                colors: [
                              Colors.teal.shade900,
                              Colors.teal.shade800,
                              Colors.teal.shade600
                            ])),
                        child: Container(
                            padding:
                                EdgeInsets.only(top: 50, bottom: 20, left: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocListener<DrawerBloc, DrawerState>(
                                  listener: (context, state) {
                                    if (state is LogoutSuccessfulState) {
                                      navigateToSignInPageLogOut(context);
                                    }
                                  },
                                  child: BlocBuilder<DrawerBloc, DrawerState>(
                                    builder: (context, state) {
                                      if (state is LogoutSuccessfulState) {
                                        return Container();
                                      } else if (state is LogoutInitialState) {}
                                      return Container();
                                    },
                                  ),
                                ),
                                if (itemuser != null) ...[
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 50, bottom: 20),
                                    child: Column(children: [
                                      Container(
                                        decoration: ShapeDecoration(
                                            color: Colors.teal.shade300,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100)))),
                                        width: 103,
                                        height: 103,
                                        padding: EdgeInsets.all(3),
                                        child: Container(
                                            width: 100,
                                            height: 100,
                                            child: ClipOval(
                                              child: FadeInImage(
                                                placeholder: AssetImage(
                                                    './assets/images/load.gif'),
                                                image: NetworkImage(image!),
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${itemuser!.name}',
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Điểm tích lũy: ${itemuser!.point}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ]),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Profile(
                                                    userResponsitory:
                                                        widget.userResponsitory,
                                                    user: widget.user,
                                                    itemUser: itemuser,
                                                  )));
                                    },
                                    child: MenuItem(
                                        'Cá Nhân', Icons.people_alt_rounded),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListOrder()));
                                    },
                                    child: MenuItem('Lịch Sử Hóa Đơn',
                                        Icons.receipt_long_rounded),
                                  ),
                                ] else ...[
                                  Column(
                                    children: [
                                      SizedBox(height: 50),
                                      MaterialButton(
                                        onPressed: () {
                                          navigateToSignInPage(context);
                                        },
                                        minWidth: 200,
                                        color: Colors.teal.shade700,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Text(
                                          'Đăng Nhập',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          navigateToRegisterPage(context);
                                        },
                                        minWidth: 200,
                                        color: Colors.teal.shade700,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Text(
                                          'Đăng Kí',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(height: 50),
                                    ],
                                  )
                                ],
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FavoritesScreen()));
                                  },
                                  child: MenuItem(
                                      'Yêu Thích', Icons.favorite_rounded),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Contact()));
                                  },
                                  child: MenuItem(
                                      'Liên Hệ', Icons.contact_support_rounded),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Rules()));
                                  },
                                  child: MenuItem(
                                      'Điều Khoản', Icons.feed_rounded),
                                ),
                                SizedBox(height: 100),
                                if (widget.user != null) ...[
                                  InkWell(
                                    onTap: () {
                                      homePageBloc!
                                          .add(LogOutButtonOnPressState());
                                    },
                                    child: MenuItem(
                                        'Đăng Xuất', Icons.logout_outlined),
                                  )
                                ]
                              ],
                            )))))));
  }

  Widget MenuItem(String Title, IconData icon) {
    return Container(
      child: GestureDetector(
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
              Title,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ))
          ],
        ),
      ),
    );
  }

  void navigateToSignInPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginPageParent(userRepository: widget.userResponsitory);
    }));
  }

  void navigateToSignInPageLogOut(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return LoginPageParent(userRepository: widget.userResponsitory);
    }));
  }

  void navigateToRegisterPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignUpPageParent(userRepository: widget.userResponsitory);
    }));
  }
}
