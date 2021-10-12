import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:plants_app/screens/contact.dart';
import 'package:plants_app/screens/home.dart';
import 'package:plants_app/screens/notification.dart';
import 'package:plants_app/screens/product.dart';
import 'package:plants_app/screens/promotion.dart';

class Dashboard extends KFDrawerContent {
  Dashboard({Key? key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentTab = 0;
  Color noActive = Colors.grey.shade500;
  Color active = Colors.teal.shade700;
  final List<Widget> screens = [
    Contact(),
    Product(),
    Promotion(),
    Noti(),
  ];
  PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              currentScreen = Home();
              currentTab = 0;
            });
          },
          child: Icon(
            currentTab == 0 ? Icons.home_rounded : Icons.home_outlined,
          ),
          backgroundColor: active,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Promotion();
                            currentTab = 1;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              currentTab == 1
                                  ? Icons.local_play_rounded
                                  : Icons.local_play_outlined,
                              color: currentTab == 1 ? active : noActive,
                            ),
                            Text(
                              'Ưu Đãi',
                              style: TextStyle(
                                color: currentTab == 1 ? active : noActive,
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Noti();
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              currentTab == 2
                                  ? Icons.local_mall_rounded
                                  : Icons.local_mall_outlined,
                              color: currentTab == 2 ? active : noActive,
                            ),
                            Text(
                              'Sản Phẩm',
                              style: TextStyle(
                                color: currentTab == 2 ? active : noActive,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Contact();
                            currentTab = 3;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              currentTab == 3
                                  ? Icons.notifications_on_rounded
                                  : Icons.notifications_on_outlined,
                              color: currentTab == 3 ? active : noActive,
                            ),
                            Text(
                              'Thông Báo',
                              style: TextStyle(
                                color: currentTab == 3 ? active : noActive,
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Promotion();
                            currentTab = 4;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              currentTab == 4
                                  ? Icons.contact_support_rounded
                                  : Icons.contact_support_outlined,
                              color: currentTab == 4 ? active : noActive,
                            ),
                            Text(
                              'Liên Hệ',
                              style: TextStyle(
                                color: currentTab == 4 ? active : noActive,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              height: 70,
            ),
            notchMargin: 10,
            shape: CircularNotchedRectangle()));
  }
}
