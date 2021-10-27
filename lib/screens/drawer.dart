import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plants_app/screens/dashboard.dart';
import 'package:plants_app/screens/favorites.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.topRight,
                    colors: [Colors.teal.shade900, Colors.teal.shade500])),
            child: Container(
                padding: EdgeInsets.only(top: 100, bottom: 20, left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                        title: Text(
                          'data',
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Điểm tích lũy: 1000000',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: Dashboard()));
                      },
                      child: MenuItem('Cá Nhân', Icons.people_alt_rounded),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: FavoritesScreen()));
                      },
                      child: MenuItem('Yêu Thích', Icons.favorite_rounded),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                duration: Duration(milliseconds: 500),
                                child: Dashboard()));
                      },
                      child: MenuItem('Đơn Hàng', Icons.receipt_long_rounded),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: Dashboard()));
                      },
                      child: MenuItem('Liên Hệ', Icons.contact_support_rounded),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: Dashboard()));
                      },
                      child: MenuItem('Điều Khoản', Icons.feed_rounded),
                    ),
                    SizedBox(height: 100),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: Dashboard()));
                      },
                      child: MenuItem('Đăng Xuất', Icons.logout_outlined),
                    )
                  ],
                ))));
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
}
