import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:plants_app/colorsize/gradienticon.dart';
import 'package:plants_app/colorsize/gradienttext.dart';
import 'package:plants_app/screens/contact.dart';
import 'package:plants_app/screens/home.dart';
import 'package:plants_app/screens/news_screen.dart/news.dart';
import 'package:plants_app/screens/notification.dart';
import 'package:plants_app/screens/product.dart';
import 'package:plants_app/screens/promotionscreen/promotion.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentTab = 0;
  Color noActive = Colors.grey.shade500;
  Color active = Colors.teal.shade800;
  final List<Widget> screens = [
    News(),
    Product(),
    Promotion(),
    Noti(),
  ];
  PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();
  bool menuOpen = false;
  double tranx = 0, trany = 0, scale = 1.0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnimatedContainer(
        duration: Duration(milliseconds: 400),
        transform: Matrix4.translationValues(tranx, trany, 0)..scale(scale),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            appBar: _buildAppBar(width, height),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  currentScreen = Home();
                  currentTab = 0;
                });
              },
              child: Container(
                width: 60,
                height: 60,
                child: Icon(
                  currentTab == 0 ? Icons.home_rounded : Icons.home_outlined,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.teal.shade800, Colors.teal.shade300])),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: PageStorage(
              child: currentScreen,
              bucket: bucket,
            ),
            bottomNavigationBar: BottomAppBar(
                elevation: 5,
                child: Container(
                  color: Colors.transparent,
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
                                if (currentTab == 1) ...[
                                  GradientIcon(Icons.local_play_rounded,
                                      gradient: LinearGradient(colors: [
                                        Colors.teal.shade900,
                                        Colors.teal.shade400,
                                      ])),
                                  GradientText(
                                    'Ưu Đãi',
                                    style: const TextStyle(fontSize: 14),
                                    gradient: LinearGradient(colors: [
                                      Colors.teal.shade900,
                                      Colors.teal.shade400,
                                    ]),
                                  ),
                                ] else ...[
                                  Icon(
                                    Icons.local_play_outlined,
                                    color: noActive,
                                  ),
                                  Text(
                                    'Ưu Đãi',
                                    style: TextStyle(
                                      color: noActive,
                                    ),
                                  )
                                ],
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                currentScreen = Product();
                                currentTab = 2;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                if (currentTab == 2) ...[
                                  GradientIcon(Icons.local_mall_rounded,
                                      gradient: LinearGradient(colors: [
                                        Colors.teal.shade900,
                                        Colors.teal.shade400,
                                      ])),
                                  GradientText(
                                    'Sản Phẩm',
                                    style: const TextStyle(fontSize: 14),
                                    gradient: LinearGradient(colors: [
                                      Colors.teal.shade900,
                                      Colors.teal.shade400,
                                    ]),
                                  ),
                                ] else ...[
                                  Icon(
                                    Icons.local_mall_outlined,
                                    color: noActive,
                                  ),
                                  Text(
                                    'Sản Phẩm',
                                    style: TextStyle(
                                      color: noActive,
                                    ),
                                  )
                                ],
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
                                currentScreen = News();
                                currentTab = 3;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                if (currentTab == 3) ...[
                                  GradientIcon(Icons.library_books_rounded,
                                      gradient: LinearGradient(colors: [
                                        Colors.teal.shade900,
                                        Colors.teal.shade400,
                                      ])),
                                  GradientText(
                                    'Tin Tức',
                                    style: const TextStyle(fontSize: 14),
                                    gradient: LinearGradient(colors: [
                                      Colors.teal.shade900,
                                      Colors.teal.shade400,
                                    ]),
                                  ),
                                ] else ...[
                                  Icon(
                                    Icons.library_books_outlined,
                                    color: noActive,
                                  ),
                                  Text(
                                    'Tin Tức',
                                    style: TextStyle(
                                      color: noActive,
                                    ),
                                  )
                                ],
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                currentScreen = Noti();
                                currentTab = 4;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                if (currentTab == 4) ...[
                                  GradientIcon(Icons.notifications_on_rounded,
                                      gradient: LinearGradient(colors: [
                                        Colors.teal.shade900,
                                        Colors.teal.shade400,
                                      ])),
                                  GradientText(
                                    'Thông Báo',
                                    style: const TextStyle(fontSize: 14),
                                    gradient: LinearGradient(colors: [
                                      Colors.teal.shade900,
                                      Colors.teal.shade400,
                                    ]),
                                  ),
                                ] else ...[
                                  Icon(
                                    Icons.notifications_on_outlined,
                                    color: noActive,
                                  ),
                                  Text(
                                    'Thông Báo',
                                    style: TextStyle(
                                      color: noActive,
                                    ),
                                  )
                                ],
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
                shape: CircularNotchedRectangle())));
  }

  AppBar _buildAppBar(double width, double height) {
    return AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: !menuOpen
                ? IconButton(
                    onPressed: () {
                      scale = 0.7;
                      tranx = width - 100;
                      trany = (height - scale * height) / 2;
                      setState(() {
                        menuOpen = true;
                      });
                    },
                    icon: Icon(
                      Icons.menu,
                      size: 30.0,
                      color: Colors.black,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      scale = 1.0;
                      tranx = 0;
                      trany = 0;
                      setState(() {
                        menuOpen = false;
                      });
                    },
                    icon: Icon(
                      Icons.menu_open_outlined,
                      size: 30,
                      color: Colors.black,
                    ))),
        centerTitle: true,
        title: Container(
          child: GradientText(
            'Plants',
            style: const TextStyle(fontSize: 40, fontFamily: 'Niconne'),
            gradient: LinearGradient(colors: [
              Colors.teal.shade900,
              Colors.teal.shade600,
            ]),
          ),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 12.0, right: 20.0),
                child: InkResponse(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Home(),
                    ),
                  ),
                  child: Icon(
                    Icons.shopping_basket,
                    size: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                bottom: 8.0,
                right: 16.0,
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade600,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: InkResponse(
              onTap: () => print('Search'),
              child: Icon(
                Icons.search,
                size: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ]);
  }
}
