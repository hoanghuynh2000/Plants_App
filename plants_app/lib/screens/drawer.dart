import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:plants_app/screens/classbuilder.dart';

import 'package:plants_app/screens/home.dart';

class MainWidget extends KFDrawerContent {
  MainWidget();

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  KFDrawerController? _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('Dashboard'),
      items: [
        KFDrawerItem.initWithPage(
          text:
              Text('Home', style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.home, color: Colors.white),
          page: Home(),
        ),
        // KFDrawerItem.initWithPage(
        //   text: Text(
        //     'Profile',
        //     style: TextStyle(color: Colors.white, fontSize: 18),
        //   ),
        //   icon: Icon(Icons.account_box, color: Colors.white),
        //   page: Favourite(),
        // ),

        // KFDrawerItem.initWithPage(
        //   text: Text(
        //     'Stats',
        //     style: TextStyle(color: Colors.white, fontSize: 18),
        //   ),
        //   icon: Icon(Icons.trending_up, color: Colors.white),
        //   page: Stats(),
        // ),
        // KFDrawerItem.initWithPage(
        //   text: Text(
        //     'Schedules',
        //     style: TextStyle(color: Colors.white, fontSize: 18),
        //   ),
        //   icon: Icon(Icons.av_timer, color: Colors.white),
        //   page: Schedules(),
        // ),
        // KFDrawerItem.initWithPage(
        //   text: Text(
        //     'Settings',
        //     style: TextStyle(color: Colors.white, fontSize: 18),
        //   ),
        //   icon: Icon(Icons.settings, color: Colors.white),
        //   page: Settings(),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          image: AssetImage('images/image.jpg'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('Scarlett Johansson',
                        style:
                            new TextStyle(fontSize: 17, color: Colors.white)),
                    new SizedBox(height: 2),
                    new Text('Actress',
                        style: new TextStyle(fontSize: 15, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'Logout',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(31, 58, 47, 1.0),
              Color.fromRGBO(31, 58, 47, 1.0)
            ],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
