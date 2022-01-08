// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/firebase/address.dart';
import 'package:plants_app/firebase/detailorder.dart';
import 'package:plants_app/firebase/notification.dart';
import 'package:plants_app/firebase/oder.dart';
import 'package:plants_app/firebase/product.dart';
import 'package:plants_app/firebase/promotion.dart';
import 'package:plants_app/firebase/shoppingcart.dart';
import 'package:plants_app/layoutdrawer.dart';
import 'package:plants_app/model/mdAddress.dart';
import 'package:plants_app/model/mdUser.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:plants_app/model/mddetailshoppingcart.dart';
import 'package:plants_app/model/mdpromotion.dart';
import 'package:plants_app/payment/paypalscreen.dart';
import 'package:plants_app/screens/home.dart';
import 'package:plants_app/screens/shoppingcart.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'addess_delivery/infor_delivery.dart';

class Order extends StatefulWidget {
  String? idAddress;
  Order({Key? key, this.idAddress}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  bool status = false;
  String nameCus = "";
  String phoneCus = "";
  String addressCus = "";
  String city = '';
  String dayPayment = "12/10/2021";
  String state = 'Chờ xác nhận';
  bool cash = false;
  bool paymentOnl = false;

  String UID = "";
  List<MDDetailShoppingCart> listPro = [];
  FetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    UID = user!.uid;
  }

  List<MDUser> listUser = [];
  List<MDPromotion> listPromotion = [];
  DetailProduct detailProduct = new DetailProduct();
  FetchDataPromotion(String id) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await DataPromotion().getIDPromotion(id);

    if (result == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          listPromotion = result;
        });
      } else
        print('unable');
    }
  }

  List<MDAddress> listAddress = [];
  FetchAddress() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result =
        await AddressFirebase().getAddressListId(widget.idAddress.toString());

    if (result == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          listAddress = result;
          if (listAddress.isNotEmpty) {
            nameCus = listAddress[0].name.toString();
            phoneCus = listAddress[0].phonenumber.toString();
            addressCus = listAddress[0].street.toString();
            city = listAddress[0].address.toString();
          }
        });
      }
    }
  }

  FetchDataShoppingCart() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await FirShoppingCart().getListShoppingCart(UID);
    dynamic resultUser = await FirListOder().getUser();
    //dynamic resultPro = await DataProduct().getCateProductList(widget.detailProduct.idCate);
    if (result == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          listUser = resultUser;
          listPro = result;
          diemThuong = int.tryParse(listUser[0].point.toString())!;
          for (int i = 0; i < listPro.length; i++) {
            soluongtong = soluongtong + int.parse(listPro[i].quantity);
            int sotien =
                (int.parse(listPro[i].price)) * int.parse(listPro[i].quantity);

            tongTien = tongTien + sotien;
          }
        });
      }
    }
  }

  int diemThuong = 0;
  Widget DoiDiem(bool check) {
    if (check == true) {
      return Text("Đổi Điểm", style: TextStyle(fontSize: 15));
    } else {
      return Text('');
    }
  }

  Widget Diem(bool check, int diem) {
    if (check == true) {
      return Text(
          '-${NumberFormat('###,###').format(int.parse(diem.toString()))}',
          style: TextStyle(fontSize: 16));
    } else {
      return Text('');
    }
  }

  var thanhToan = 0;
  int soluongtong = 0;
  int tongTien = 0;
  int phiVanChuyen = 30000;

  final promotionController = new TextEditingController();
  String promotion = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchUserInfo();
    FetchDataShoppingCart();
    FetchAddress();
  }

  Widget listViewPro() {
    return ListView.builder(
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
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(listPro[index].images),
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
                    '${listPro[index].productName}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '  ${listPro[index].categoryName}',
                    style: TextStyle(color: Colors.teal.shade500),
                  ),
                  Text(
                      '  ${NumberFormat('###,###').format(int.parse(listPro[index].price.toString()))}',
                      style: TextStyle(color: Colors.red, fontSize: 16))
                ],
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
          );
        });
  }

  Widget AddressDelivery() {
    if (listAddress.isNotEmpty) {
      return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.teal.shade800, width: 0.5),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.only(top: 15, left: 15, right: 15),
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 3 / 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nameCus,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      phoneCus,
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      addressCus,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      city,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.navigate_next_outlined),
            ],
          ));
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.teal.shade800, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.pin_drop_outlined, color: Colors.teal.shade700),
            Text('Thêm thông tin giao hàng'),
            Icon(Icons.navigate_next_outlined),
          ],
        ),
      );
    }
  }

  int giamGia = 0;
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String idOrder =
        DateFormat('yyyyMMddhhmmss').format(now) + UID.substring(0, 5);
    FetchAddress();
    int diemdoi = diemThuong * 100;
    double height = MediaQuery.of(context).size.height;

    if (status == true) {
      thanhToan = tongTien + phiVanChuyen - giamGia - (diemThuong * 100);
      if (thanhToan < 0) {
        thanhToan = 0;
      }
    } else {
      thanhToan = tongTien + phiVanChuyen - giamGia;
      if (thanhToan < 0) {
        thanhToan = 0;
      }
    }
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
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InforDelivery()));
                },
                child: AddressDelivery()),
            listViewPro(),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Số lượng:  $soluongtong '), SizedBox(width: 30)],
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
                  Divider(
                    color: Colors.teal.shade900,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 200,
                        padding: EdgeInsets.only(top: 5),
                        child: TextField(
                            controller: promotionController,
                            onChanged: (value) {
                              setState(() {
                                promotion = value;
                                FetchDataPromotion(promotion);
                              });
                            },
                            style: TextStyle(fontSize: 17),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                focusColor: Colors.teal,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                      BorderSide(color: Colors.teal.shade300),
                                ),
                                prefixIcon: Icon(
                                  Icons.local_offer,
                                  color: Colors.teal.shade700,
                                ),
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
                        onPressed: () {
                          FetchDataPromotion(promotion);
                          setState(() {
                            if (listPromotion.isNotEmpty) {
                              int phantram = int.parse(
                                  listPromotion[0].discount.toString());

                              giamGia = (tongTien * phantram) ~/ 100;
                              if (giamGia >
                                  int.parse(listPromotion[0]
                                      .discountMax
                                      .toString())) {
                                giamGia = int.parse(
                                    listPromotion[0].discountMax.toString());
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Mã giảm giá không tồn tại")));
                            }
                          });
                        },
                        child: Text(
                          'Áp dụng',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Comfortaa',
                              fontSize: 16),
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
                            style: TextStyle(color: Colors.grey.shade700),
                          )
                        ],
                      ),
                      SizedBox(width: 60),
                      SizedBox(
                        height: 25,
                        width: 60,
                        child: FlutterSwitch(
                          activeColor: Colors.teal.shade800,
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
                      DoiDiem(status),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Thanh Toán  ',
                          style: TextStyle(
                              // fontFamily: 'Lemonada',
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${NumberFormat('###,###').format(tongTien)}',
                          style: TextStyle(fontSize: 16)),
                      Text('${NumberFormat('###,###').format(phiVanChuyen)}',
                          style: TextStyle(fontSize: 16)),
                      Text('-${NumberFormat('###,###').format(giamGia)}',
                          style: TextStyle(fontSize: 16)),
                      Diem(status, diemdoi),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.teal.shade900,
                      ),
                      Text('${NumberFormat('###,###').format(thanhToan)}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700)),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            cash = true;
                            paymentOnl = false;
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    blurRadius: 4,
                                    offset: Offset(1, 4), // Shadow position
                                  ),
                                ],
                                color: cash
                                    ? Colors.teal.shade50.withOpacity(0.9)
                                    : Colors.white,
                                // border: Border.all(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.payments_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Thanh toán tiền mặt',
                                    style: TextStyle(fontSize: 17)),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            cash = false;
                            paymentOnl = true;
                          });
                        },
                        child: Container(
                          width: 350,
                          decoration: BoxDecoration(
                              color: paymentOnl
                                  ? Colors.teal.shade50.withOpacity(0.9)
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  blurRadius: 4,
                                  offset: Offset(1, 4), // Shadow position
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Image(
                            image: AssetImage("./assets/images/paypal.png"),
                            height: 45,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      color: Colors.white,
                      height: 40,
                      minWidth: 100,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red.shade700),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: () {},
                      child: Text(
                        'Hủy',
                        style:
                            TextStyle(color: Colors.red.shade700, fontSize: 16),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.teal.shade900,
                      height: 40,
                      minWidth: 210,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: () async {
                        if (cash == false && paymentOnl == false) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Vui lòng chọn phương thức thanh toán')));
                        } else if (nameCus.isEmpty &&
                            phoneCus.isEmpty &&
                            addressCus.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Vui lòng chọn địa chỉ giao hàng')));
                        } else {
                          String payment = '';
                          String statePayment = '';
                          if (cash == true) {
                            payment = 'Thanh toán khi nhận hàng';
                            statePayment = 'Chưa thanh toán';
                            if (status == false) {
                              diemdoi = 0;
                            }

                            for (int i = 0; i < listPro.length; i++) {
                              String idPro = listPro[i].idProduct;
                              DetailProduct detailProduct = new DetailProduct();

                              dynamic resultPro =
                                  await DataProduct().getProductIdList(idPro);
                              detailProduct = resultPro;
                              int slTon = int.parse(detailProduct.quantity);
                              int slSau =
                                  slTon - int.parse(listPro[i].quantity);
                              DataProduct()
                                  .updateSoLuong(idPro, slSau.toString());
                              //String totalPrice= (int.parse(listPro[i].price)*int.parse(listPro[i].quantity)).toString();
                              FirListDetailOrder().addListDetailOrder(
                                  UID,
                                  listPro[i].quantity,
                                  listPro[i].price,
                                  idOrder,
                                  idPro,
                                  listPro[i].images,
                                  listPro[i].productName);
                            }
                            addressCus = addressCus + " " + city;
                            FirListOder().addListOrder(
                                UID,
                                nameCus,
                                phoneCus,
                                addressCus,
                                idOrder,
                                state,
                                formattedDate,
                                '',
                                giamGia.toString(),
                                diemdoi.toString(),
                                payment,
                                soluongtong.toString(),
                                thanhToan.toString(),
                                statePayment,
                                phiVanChuyen.toString(),
                                tongTien.toString());
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(content: Text('Đặt hàng thành công')));
                            FirShoppingCart().removeProductorder();
                            if (status == false) {
                              diemdoi = 0;
                              int diem = thanhToan ~/ 10000;
                              diemThuong = diemThuong + diem;
                              FirListOder().updateDiem(diemThuong.toString());
                            } else {
                              int diem = thanhToan ~/ 10000;
                              diemThuong = 0;
                              diemThuong = diemThuong + diem;
                              FirListOder().updateDiem(diemThuong.toString());
                            }
                            FirNotification().addListNoti(
                                'Bạn đã đặt hàng thành công ' + idOrder,
                                formattedDate);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Đặt hàng thành công')));
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LayoutDrawer()),
                                (route) => false);
                          } else if (paymentOnl == true) {
                            payment = 'Paypal';
                            statePayment = 'Đã thanh toán';
                            if (status == false) {
                              diemdoi = 0;
                            }

                            for (int i = 0; i < listPro.length; i++) {
                              String idPro = listPro[i].idProduct;
                              DetailProduct detailProduct = new DetailProduct();

                              dynamic resultPro =
                                  await DataProduct().getProductIdList(idPro);
                              detailProduct = resultPro;
                              int slTon = int.parse(detailProduct.quantity);
                              int slSau =
                                  slTon - int.parse(listPro[i].quantity);
                              DataProduct()
                                  .updateSoLuong(idPro, slSau.toString());
                              //String totalPrice= (int.parse(listPro[i].price)*int.parse(listPro[i].quantity)).toString();
                              FirListDetailOrder().addListDetailOrder(
                                  UID,
                                  listPro[i].quantity,
                                  listPro[i].price,
                                  idOrder,
                                  idPro,
                                  listPro[i].images,
                                  listPro[i].productName);
                            }
                            addressCus = addressCus + city;
                            FirListOder().addListOrder(
                                UID,
                                nameCus,
                                phoneCus,
                                addressCus,
                                idOrder,
                                state,
                                formattedDate,
                                '',
                                giamGia.toString(),
                                diemdoi.toString(),
                                payment,
                                soluongtong.toString(),
                                thanhToan.toString(),
                                statePayment,
                                phiVanChuyen.toString(),
                                tongTien.toString());
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(content: Text('Đặt hàng thành công')));
                            FirShoppingCart().removeProductorder();
                            if (status == false) {
                              diemdoi = 0;
                              int diem = thanhToan ~/ 10000;
                              diemThuong = diemThuong + diem;
                              FirListOder().updateDiem(diemThuong.toString());
                            } else {
                              int diem = thanhToan ~/ 10000;
                              diemThuong = 0;
                              diemThuong = diemThuong + diem;
                              FirListOder().updateDiem(diemThuong.toString());
                            }
                            String thanhToanPaypal =
                                (thanhToan / 22930).toStringAsFixed(2);
                            FirNotification().addListNoti(
                                'Bạn đã đặt hàng thành công đơn hàng' + idOrder,
                                formattedDate);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PaypalPayment(
                                        nameCus: nameCus,
                                        phoneCus: phoneCus,
                                        addressCus: addressCus,
                                        price: thanhToanPaypal,
                                        idOrder: idOrder,
                                        onFinish: (number) async {})));
                          }

                          //     UsePaypal(
                          //         sandboxMode: true,
                          //         clientId:
                          //             "AfmmrjM6C0v2XWHuyNKtlUFKPEWa59vVHlUd3DzER92kzC1nYBXzvs44xNwpQn3Calc53HqC2gZTvE5B",
                          //         secretKey:
                          //             "EO6dk7P1FKpY4NpY7GZZa3eFl3NOITYLrxAOFbaGy2bN3YkoeB30f-P3_qvJ8gDY-aQr4cKDeNI6UXsZ",
                          //         returnURL: "https://samplesite.com/return",
                          //         cancelURL: "https://samplesite.com/cancel",
                          //         transactions: [
                          //           {
                          //             "amount": {
                          //               "total":
                          //                   '${thanhToanPaypal.toString()}',
                          //               "currency": "USD",
                          //               "details": {
                          //                 "subtotal":
                          //                     '${thanhToanPaypal.toString()}',
                          //                 "shipping": '0',
                          //                 "shipping_discount": 0
                          //               }
                          //             },
                          //             "description":
                          //                 "The payment transaction description.",
                          //             // "payment_options": {
                          //             //   "allowed_payment_method":
                          //             //       "INSTANT_FUNDING_SOURCE"
                          //             // },
                          //             "item_list": {
                          //               "items": [
                          //                 {
                          //                   "name": "Thanh toán đơn hàng: " +
                          //                       idOrder,
                          //                   "quantity": 1,
                          //                   "price":
                          //                       '${thanhToanPaypal.toString()}',
                          //                   "currency": "USD"
                          //                 }
                          //               ],

                          //               // shipping address is not required though
                          //               "shipping_address": {
                          //                 "recipient_name": nameCus,
                          //                 "line1": addressCus,
                          //                 "line2": "",
                          //                 "city": city,
                          //                 "country_code": "VN",
                          //                 "postal_code": "73301",
                          //                 "phone": phoneCus,
                          //                 "state": ""
                          //               },
                          //             }
                          //           }
                          //         ],
                          //         note:
                          //             "Contact us for any questions on your order.",
                          //         onSuccess: (Map params) async {
                          //           print("onSuccess: $params");
                          //         },
                          //         onError: (error) {
                          //           print("onError: $error");
                          //         },
                          //         onCancel: (params) {
                          //           print('cancelled: $params');
                          //         }),
                          //   ),
                          // );

                        }
                      },
                      child: Text(
                        'Xác Nhận Thanh Toán',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ))
          ]),
        )));
  }
}

class changeConst {
  final int pay;
  const changeConst(this.pay);
}
