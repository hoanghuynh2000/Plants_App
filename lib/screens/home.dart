import 'package:animator/animator.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:plants_app/listproduct.dart';
import 'package:plants_app/model/mdcategory.dart';

import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/model/mdnews.dart';
import 'package:plants_app/screens/detailproduct/itemproduct.dart';
import 'package:plants_app/screens/news_screen.dart/detail_news.dart';

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
  List<MDNews> lsNews = [
    MDNews(
        id: '1',
        nameNews: 'Hướng dẫn chăm sóc',
        imageNews: 'assets/images/logo.png',
        detailNews: 'Những cách trồng cây hay nhất Việt Nam'),
    MDNews(
        id: '1',
        nameNews: 'Hướng dẫn chăm sóc',
        imageNews: 'assets/images/logo.png',
        detailNews: 'Những cách trồng cây hay nhất Việt Nam'),
    MDNews(
        id: '1',
        nameNews: 'Hướng dẫn chăm sóc',
        imageNews: 'assets/images/logo.png',
        detailNews:
            'Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam.Những cách trồng cây hay nhất Việt NamNhững cách trồng cây hay nhất Việt Nam'),
    MDNews(
        id: '1',
        nameNews: 'Hướng dẫn chăm sóc',
        imageNews: 'assets/images/logo.png',
        detailNews:
            'Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam.Những cách trồng cây hay nhất Việt NamNhững cách trồng cây hay nhất Việt Nam'),
    MDNews(
        id: '1',
        nameNews: 'Hướng dẫn chăm sóc',
        imageNews: 'assets/images/logo.png',
        detailNews:
            'Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam.Những cách trồng cây hay nhất Việt NamNhững cách trồng cây hay nhất Việt Nam'),
  ];
  List<Category> listCate = [
    Category(
        id: '1', nameCate: 'Cây Cảnh Mini', imgCate: 'assets/images/logo.png'),
    Category(
        id: '12', nameCate: 'Cây Cảnh Mini', imgCate: 'assets/images/logo.png'),
    Category(
        id: '123',
        nameCate: 'Cây Cảnh Mini',
        imgCate: 'assets/images/logo.png'),
    Category(
        id: '123',
        nameCate: 'Cây Cảnh Mini',
        imgCate: 'assets/images/logo.png'),
    Category(
        id: '123', nameCate: 'Cây Cảnh Mini', imgCate: 'assets/images/logo.png')
  ];
  List<DetailProduct> listPro = [
    DetailProduct(
        id: '123',
        namePro: 'Cây Xương Rồng',
        pricePro: 120000,
        descrip: 'Hihi',
        quantity: 20,
        imgProduct: 'assets/images/logo.png',
        idCate: '1'),
    DetailProduct(
        id: '123',
        namePro: 'Cây Xương Rồng qqqqqqqqqqqqqqqqqqqqq',
        pricePro: 120000,
        descrip: 'Hihi',
        quantity: 20,
        imgProduct: 'assets/images/logo.png',
        idCate: '1'),
    DetailProduct(
        id: '123',
        namePro: 'Cây Xương Rồngqqqqqqqqqqqqqqqqqqqqqqqqqqqq',
        pricePro: 120000,
        descrip: 'Hihi',
        quantity: 20,
        imgProduct: 'assets/images/logo.png',
        idCate: '3'),
    DetailProduct(
        id: '123',
        namePro: 'Cây Xương Rồng',
        pricePro: 120000,
        descrip: 'Hihi',
        quantity: 20,
        imgProduct: 'assets/images/logo.png',
        idCate: '2')
  ];

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
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  child: Text('Danh Mục Sản Phẩm',
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
                  child: Text('Sản Phẩm Mới',
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
                SizedBox(
                  child: Text('Tin Mới Nhất',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Dosis',
                          color: Colors.teal.shade900)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(height: 400, child: _buildNews())
              ])),
            )));
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
                  width: 160,
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
                        width: 160,
                        height: 90,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Center(
                                heightFactor: 0.7,
                                child: FadeInImage(
                                  placeholder:
                                      AssetImage('./assets/images/load.gif'),
                                  image:
                                      AssetImage('${listCate[index].imgCate}'),
                                  fit: BoxFit.fitHeight,
                                ))),
                        decoration: ShapeDecoration(
                            color: Colors.brown.shade100.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${listCate[0].nameCate}',
                        maxLines: 1,
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  )));
        });
  }

// TIN TỨC
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
                            color: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            image: DecorationImage(
                                image: AssetImage('${lsNews[index].imageNews}'),
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
      itemCount: listPro.length,
    );
  }
}
