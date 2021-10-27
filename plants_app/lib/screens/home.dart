import 'package:animator/animator.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:plants_app/model/mdcategory.dart';

import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/screens/detailproduct/itemproduct.dart';

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
  List<Category> listCate = [
    Category(
        id: '123',
        nameCate: 'Cây Cảnh Mini',
        imgCate: 'assets/images/logo.png'),
    Category(
        id: '123',
        nameCate: 'Cây Cảnh Mini',
        imgCate: 'assets/images/logo.png'),
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
        idCate: '123'),
    DetailProduct(
        id: '123',
        namePro: 'Cây Xương Rồng qqqqqqqqqqqqqqqqqqqqq',
        pricePro: 120000,
        descrip: 'Hihi',
        quantity: 20,
        imgProduct: 'assets/images/logo.png',
        idCate: '123'),
    DetailProduct(
        id: '123',
        namePro: 'Cây Xương Rồngqqqqqqqqqqqqqqqqqqqqqqqqqqqq',
        pricePro: 120000,
        descrip: 'Hihi',
        quantity: 20,
        imgProduct: 'assets/images/logo.png',
        idCate: '123'),
    DetailProduct(
        id: '123',
        namePro: 'Cây Xương Rồng',
        pricePro: 120000,
        descrip: 'Hihi',
        quantity: 20,
        imgProduct: 'assets/images/logo.png',
        idCate: '123')
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
          child: Column(children: [
        InkWell(
          onTap: () {},
          child: CarouselSlider(
            items: imgList
                .map((item) => Container(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
        Text('Danh Mục Sản Phẩm',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Dosis',
                color: Colors.teal.shade900)),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          // Design Category
          child: _buildCategory(),
        ),
        SizedBox(
          height: 10,
        ),
        Text('Sản Phẩm Mới',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Dosis',
                color: Colors.teal.shade900)),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 260,
          child: _buildNewProduct(),
        ),
        SizedBox(
          height: 30,
        ),
      ])),
    ));
  }

  Widget _buildCategory() {
    //print(listCate[0].imgCate);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(6),
          decoration: ShapeDecoration(
              shadows: [
                BoxShadow(
                    offset: Offset(0, 3),
                    color: Colors.grey.shade300,
                    blurRadius: 10)
              ],
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
          //margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Container(
                width: 120,
                decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage('${listCate[index].imgCate}'),
                      fit: BoxFit.contain,
                      //height: 150,
                    ),
                    color: Colors.blueGrey.shade50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                height: 120,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${listCate[0].nameCate}',
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        );
      },
      itemCount: listCate.length,
    );
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
