import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/fake/fakelistorder.dart';
import 'package:plants_app/fake/productfake.dart';
import 'package:plants_app/model/mddetailorder.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/model/mdorder.dart';

class DetailsOrder extends StatefulWidget {
  String mdDetail;
  DetailsOrder({required this.mdDetail});

  @override
  _DetailsOrderState createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  String? nameCus = 'Nguyen Nguyen';
  String? phoneCus = '0123456xxx';
  String? addressCus = '828 Su Van Hanh';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<mdOrder> list = fakeListOrder
        .where((element) => element.idOrder == widget.mdDetail)
        .toList();
    List<DetailProduct> listPro = FakeProduct.toList();
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
            title: Text('Chi tiết đơn hàng'),
            backgroundColor: Colors.teal.shade900),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, left: 15),
                child: Text('${list[0].state}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa',
                        color: Colors.teal.shade700)),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            '$nameCus',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'itim'),
                          ),
                        ),
                        Text(
                          '$phoneCus',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('$addressCus', style: TextStyle(fontSize: 15))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listPro.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  '${listPro[index].imgProduct}'),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${listPro[index].namePro}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                              '${NumberFormat('###,###').format(listPro[index].pricePro)}',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('${listPro[index].quantity}'),
                                        SizedBox(
                                          width: 15,
                                        )
                                      ],
                                    ))
                                  ]),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Container(
                                  height: 1.0,
                                  width: 250.0,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ));
                    }),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                padding:
                    EdgeInsets.only(left: 25, right: 25, bottom: 15, top: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tổng tiền  ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text('Phí vận chuyển  ',
                            style: TextStyle(fontSize: 15)),
                        Text('Giảm giá  ', style: TextStyle(fontSize: 15)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Thanh Toán  ',
                            style: TextStyle(
                                fontFamily: 'Lemonada',
                                fontSize: 13,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            '${NumberFormat('###,###').format(list[0].totalPrice)}',
                            style: TextStyle(fontSize: 16)),
                        Text(
                            '${NumberFormat('###,###').format(list[0].costShip)}',
                            style: TextStyle(fontSize: 16)),
                        Text(
                            '-${NumberFormat('###,###').format(list[0].promotion)}',
                            style: TextStyle(
                                color: Colors.red.shade800, fontSize: 16)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            '${NumberFormat('###,###').format(list[0].totalPrice)}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ))
                  ],
                ),
              ),
              Container(
                width: width,
                margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mã đơn hàng: ${list[0].idOrder}',
                      style: TextStyle(
                          color: Colors.teal.shade800,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('Đặt hàng vào ngày ${list[0].date}',
                        style: TextStyle(color: Colors.grey.shade700)),
                    Text('Phương thức thanh toán bằng ${list[0].payment}',
                        style: TextStyle(color: Colors.grey.shade700)),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: MaterialButton(
                    minWidth: 100,
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    color: Colors.red.shade700,
                    onPressed: () {},
                    child: Text(
                      'Hủy Đơn Hàng',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Lemonada'),
                    ),
                  ),
                )
              ])
            ],
          ),
        ));
  }
}
