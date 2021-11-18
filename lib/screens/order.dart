import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Order extends StatefulWidget {
  Order({Key? key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  bool status = false;
  String nameCus = "Nguyen Nguyen Nguyen";
  String phoneCus = "0123456789";
  String addressCus = "828 Su Van Hanh phuong 13 quan 10 thanh pho Ho Chi Minh";
  String dayPayment = "12/10/2021";
  String? namePro = 'Cây Xương Rồng.............';
  String? idPro = '123';
  int? price = 120000;
  String category = "Xương Rồng";
  String image = "assets/images/caydemo.png";
  int soLuong = 2;
  int soluongtong = 6;
  int tongTien = 360000;
  int phiVanChuyen = 25000;
  int giamGia = 30000;
  int thanhToan = 355000;
  int diemThuong = 120;
  List<DetailProduct> listPro = [
    DetailProduct(
        id: '123',
        namePro: 'Cây Xương Rồng',
        idCate: 'xương rồng',
        pricePro: 120000,
        imgProduct: "assets/images/caydemo.png",
        quantity: 2,
        descrip: '0......'),
    DetailProduct(
        id: '123',
        namePro: 'Cây Hoa Sen Nước',
        idCate: 'xương rồng',
        pricePro: 120000,
        imgProduct: "assets/images/caydemo.png",
        quantity: 2,
        descrip: '0......'),
    DetailProduct(
        id: '123',
        namePro: 'Cây Bông Bụp',
        idCate: 'xương rồng',
        pricePro: 120000,
        imgProduct: "assets/images/caydemo.png",
        quantity: '2',
        descrip: '0......'),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
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
          title: Text('Xác nhận đơn hàng'),
          backgroundColor: Colors.teal.shade700,
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 250,
                    child: Text(nameCus,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lemonada')),
                  ),
                  Text(
                    phoneCus,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(addressCus),
                ],
              ),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listPro.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                            width: 35,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${listPro[index].namePro}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '  ${listPro[index].idCate}',
                                style: TextStyle(color: Colors.teal.shade500),
                              ),
                              Text(
                                  '  ${NumberFormat('###,###').format(int.parse(listPro[index].pricePro.toString()))}',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16))
                            ],
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${soLuong}'),
                              SizedBox(
                                width: 15,
                              )
                            ],
                          ))
                        ]),
                  );
                }),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Số lượng:  ${soluongtong} '),
                SizedBox(width: 30)
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('  Mã khuyến mãi',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: Colors.teal.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 200,
                        child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))))),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        color: Colors.teal.shade900,
                        onPressed: () {},
                        child: Text(
                          'Áp dụng',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Itim',
                              fontSize: 18),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Điểm của bạn ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text('Đổi điểm  ', style: TextStyle(fontSize: 15))
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$diemThuong',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${NumberFormat('###,###').format(diemThuong * 100)} vnd',
                            style: TextStyle(color: Colors.redAccent.shade700),
                          )
                        ],
                      ),
                      SizedBox(width: 60),
                      SizedBox(
                        height: 25,
                        width: 60,
                        child: FlutterSwitch(
                          activeColor: Colors.teal.shade900,
                          value: status,
                          onToggle: (val) {
                            setState(() {
                              status = val;
                            });
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
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
                      Text('Phí vận chuyển  ', style: TextStyle(fontSize: 15)),
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
                      Text('${NumberFormat('###,###').format(tongTien)}',
                          style: TextStyle(fontSize: 16)),
                      Text('${NumberFormat('###,###').format(phiVanChuyen)}',
                          style: TextStyle(fontSize: 16)),
                      Text('${NumberFormat('###,###').format(giamGia)}',
                          style: TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${NumberFormat('###,###').format(thanhToan)}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phương thức thanh toán',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 17,
                          color: Colors.teal.shade800,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Text('Thanh toán tiền mặt'),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Text('Thanh toán ví điện tử'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: Colors.red.shade700,
                  height: 40,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  onPressed: () {},
                  child: Text(
                    'Hủy',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Itim', fontSize: 18),
                  ),
                ),
                MaterialButton(
                  color: Colors.teal.shade900,
                  height: 40,
                  minWidth: 210,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  onPressed: () {},
                  child: Text(
                    'Xác Nhận Thanh Toán',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, fontFamily: 'Itim'),
                  ),
                ),
              ],
            ))
          ]),
        )));
  }
}
