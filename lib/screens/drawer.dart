import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_bloc.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_event.dart';
import 'package:plants_app/bloc/drawerBloc/drawer_state.dart';
import 'package:plants_app/respository/user_respon.dart';
import 'package:plants_app/screens/contact.dart';
import 'package:plants_app/screens/dashboard.dart';
import 'package:plants_app/screens/favorites.dart';
import 'package:plants_app/screens/listorder.dart';
import 'package:plants_app/screens/login.dart';
import 'package:plants_app/screens/profile/profile.dart';
import 'package:plants_app/screens/rules.dart';

class DrawerParent extends StatelessWidget {
  User? user;
  UserResponsitory? userResponsitory;
  DrawerParent({this.user, this.userResponsitory});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DrawerBloc(userResponsitory: userResponsitory),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    homePageBloc = BlocProvider.of<DrawerBloc>(context);
    return Scaffold(
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
                            EdgeInsets.only(top: 100, bottom: 20, left: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocListener<DrawerBloc, DrawerState>(
                              listener: (context, state) {
                                if (state is LogoutSuccessfulState) {
                                  navigateToSignUpPage(context);
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
                            Container(
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                ),
                                title: Text(
                                  '${widget.user!.email}',
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Điểm tích lũy: 1000000',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()));
                              },
                              child:
                                  MenuItem('Cá Nhân', Icons.people_alt_rounded),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FavoritesScreen()));
                              },
                              child:
                                  MenuItem('Yêu Thích', Icons.favorite_rounded),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListOrder()));
                              },
                              child: MenuItem('Lịch Sử Hóa Đơn',
                                  Icons.receipt_long_rounded),
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
                              child: MenuItem('Điều Khoản', Icons.feed_rounded),
                            ),
                            SizedBox(height: 100),
                            InkWell(
                              onTap: () {
                                homePageBloc!.add(LogOutButtonOnPressState());
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return LoginPageParent(
                                      userRepository: widget.userResponsitory);
                                }));
                              },
                              child:
                                  MenuItem('Đăng Xuất', Icons.logout_outlined),
                            )
                          ],
                        ))))));
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

  void navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginPageParent(userRepository: widget.userResponsitory);
    }));
  }
}
