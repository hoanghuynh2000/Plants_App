import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.teal.shade900,
        body: Container(
            padding: EdgeInsets.only(
                top: 50, bottom: 50, left: 30, right: size.width - 300),
            color: Colors.teal.shade800,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                ),
                Text(
                  'data',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                MenuItem('Trang Chủ', Icons.home_rounded),
                MenuItem('Cá Nhân', Icons.people_alt_rounded),
                MenuItem('Yêu Thích', Icons.favorite_rounded),
                MenuItem('Đơn Hàng', Icons.receipt_long_rounded),
                MenuItem('Điều Khoản', Icons.library_books_rounded),
                SizedBox(height: 120),
                MenuItem('Đăng Xuất', Icons.logout_outlined),
              ],
            )));
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
