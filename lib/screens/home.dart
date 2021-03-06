import 'package:animator/animator.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/firebase/news.dart';

import 'package:plants_app/firebase/product.dart';
import 'package:plants_app/listproduct.dart';
import 'package:plants_app/model/mdcategory.dart';

import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/model/mdnews.dart';
import 'package:plants_app/screens/detailproduct/itemproduct.dart';
import 'package:plants_app/screens/news_screen.dart/detail_news.dart';
import 'package:plants_app/screens/news_screen.dart/newshome.dart';

class Home extends StatefulWidget {
  Home({Key? key});

  @override
  _HomeState createState() => _HomeState();
}

// Fake Data
final List<String> imgList = [
  'assets/images/cut.jpg',
  'assets/images/cut1.jpg',
  'assets/images/cut2.jpg',
  'assets/images/cut3.jpg',
  'assets/images/cut4.jpg',
  'assets/images/cut5.jpg',
];

class _HomeState extends State<Home> {
  //fake data
  List<MDNews> lsNews = [];
  int _current = 0;
  List<Category> listCate = [];
  List<DetailProduct> listPro = [];

  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await DataProduct().getAllProductList();
    dynamic category = await DataProduct().getAllCategory();
    dynamic news = await FirNews().getListNews();
    if (result == null) {
      print('unable');
    } else {
      if (this.mounted)
        setState(() {
          listPro = result;
          listCate = category;
          lsNews = news;
        });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
        bottom: false,
        child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.grey.shade200,
            body: SingleChildScrollView(
              child: Container(
                  child: Column(children: [
                SizedBox(
                  child: CarouselSlider(
                    items: imgList
                        .map((item) => Container(
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(
                                      image: AssetImage(item),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.map((url) {
                      int index = imgList.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Colors.grey.shade900
                              : Colors.grey.shade500,
                        ),
                      );
                    }).toList()),
                SizedBox(height: 20),
                SizedBox(
                  child: Text('Danh M???c S???n Ph???m',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Dosis',
                          color: Colors.teal.shade900)),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Container(
                    height: 150,
                    // Design Category
                    child: _buildCategory(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Text('S???n Ph???m M???i',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Dosis',
                          color: Colors.teal.shade900)),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Container(
                    height: 230,
                    child: _buildNewProduct(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Text('Tin M???i Nh???t',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Dosis',
                                color: Colors.teal.shade900)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewsHome()));
                        },
                        child: Text('Xem t???t c???',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Dosis',
                                color: Colors.grey.shade600)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(height: 400, child: _buildNews())
              ])),
            )));
  }

  String _setImage(int index) {
    String _mTitle = "${listCate[index].imgCate}";
    String a = "";
    if (_mTitle == a) {
      return "https://firebasestorage.googleapis.com/v0/b/appplants-fbbf8.appspot.com/o/images%2Fload.gif?alt=media&token=b9762554-540b-4122-9465-9df0fcc8ef40";
    } else {
      return "${listCate[index].imgCate}";
    }
  }

//CATEGORY
  Widget _buildCategory() {
    //print(listCate[0].imgCate);
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: listCate.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ListProduct(category: listCate[index])));
              },
              child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                      shadows: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            color: Colors.grey.shade300,
                            blurRadius: 10)
                      ],
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ))),
                  //margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 90,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Center(
                                // heightFactor: 0.7,
                                child: FadeInImage(
                              placeholder:
                                  AssetImage('./assets/images/load.gif'),
                              image: NetworkImage(_setImage(index)),
                              fit: BoxFit.fill,
                            ))),
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            '${listCate[index].nameCate}',
                            maxLines: 1,
                            style: TextStyle(fontSize: 14),
                          ))
                    ],
                  )));
        });
  }

// TIN T???C
  Widget _buildNews() {
    return ListView.builder(
        itemCount: lsNews.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailNews(news: lsNews[index])));
              },
              child: Container(
                  padding: EdgeInsets.all(7),
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            image: DecorationImage(
                                image:
                                    NetworkImage('${lsNews[index].imageNews}'),
                                fit: BoxFit.cover)),
                      ),
                      Expanded(
                          child: Container(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${lsNews[index].nameNews}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '${lsNews[index].detailNews}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  )
                                ],
                              )))
                    ],
                  )));
        });
  }

  Widget _buildNewProduct() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
              height: 180, child: ItemProduct(detailProduct: listPro[index]));
        },
        itemCount: listPro.length);
  }
}
