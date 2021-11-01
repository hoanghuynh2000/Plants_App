import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/handle/cartcounter.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/screens/product.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  String? namePro = 'Cây Xương Rồng.............';
  String? idPro = '123';
  int? price = 120000;
  String category = "Xương Rồng";
  String image = "assets/images/cay1.png";
  List<DetailProduct> listPro = [
    DetailProduct(
        id: '123',
        namePro: 'Cây Xương Rồng',
        idCate: 'xương rồng',
        pricePro: 120000,
        imgProduct: "assets/images/cay1.png",
        quantity: 2,
        descrip: '0......'),
    DetailProduct(
        id: '123',
        namePro: 'Cây Hoa Sen Nước',
        idCate: 'xương rồng',
        pricePro: 120000,
        imgProduct: "assets/images/cay1.png",
        quantity: 2,
        descrip: '0......'),
    DetailProduct(
        id: '123',
        namePro: 'Cây Bông Bụp',
        idCate: 'xương rồng',
        pricePro: 120000,
        imgProduct: "assets/images/cay1.png",
        quantity: 2,
        descrip: '0......')
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: <Color>[
                        Colors.teal.shade900,
                        Colors.teal.shade600
                      ])),
                ),
                title: Text(
                  "Giỏ Hàng",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.teal.shade800),
            body: Container(
                height: height,
                width: width,
                color: Colors.grey.shade200,
                child: Column(children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: listPro.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(image),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${listPro[index].namePro}',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      '  ${listPro[index].idCate}',
                                      style: TextStyle(
                                          color: Colors.teal.shade500),
                                    ),
                                    Text(
                                        '  ${NumberFormat('###,###').format(listPro[index].pricePro)}',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 17))
                                  ],
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Expanded(child: CartCounter())
                              ],
                            ),
                          );
                        }),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Tổng tiền :',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  width: width * 0.2,
                                ),
                                Text(
                                  '${NumberFormat('###,###').format(120000)}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepOrange.shade800,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: width * 0.8,
                            height: 40,
                            child: MaterialButton(
                              color: Colors.teal.shade900,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              onPressed: () {},
                              child: Text(
                                'Thanh Toán',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      )),
                ]))));
  }
}
