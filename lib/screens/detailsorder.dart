import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/fake/fakelistorder.dart';
import 'package:plants_app/fake/productfake.dart';
import 'package:plants_app/firebase/detailorder.dart';
import 'package:plants_app/firebase/oder.dart';
import 'package:plants_app/model/mddetailorder.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/model/mdorder.dart';

import 'listorder.dart';

class DetailsOrder extends StatefulWidget {
  String mdDetail;
  DetailsOrder({required this.mdDetail});

  @override
  _DetailsOrderState createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  
  
      List<mdDetailOrder> listProduct= [mdDetailOrder(idKhachHang: '',idOrder: '',idPro: '',namePro: '',price: '',imagePro: '')];
      List<mdOrder>listOrder=[mdOrder(idCus: '',idOrder: '',nameCus:'',addressCus: '',phoneCus: '',promotion: '1',
      totalPrice: '1',totalPayment: '1',state: '',statePayment: '',date:'',dateDelivery: '',payment: '',point: '1',quantity: '1',costShip: '1')];
  
    FetchDataPro()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); 
    dynamic result = await FirListOder().getListOrderid(widget.mdDetail);
     dynamic resultPro = await FirListDetailOrder().getListDetailOrder();
    if (result == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
        
          listOrder = result;
          listProduct=resultPro;
        });
}
      
    }
  }           
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchDataPro();
  } 
  @override
  Widget build(BuildContext context) {
    FetchDataPro();
    int index=0;
    double width = MediaQuery.of(context).size.width;
   List<mdDetailOrder>listProduct1= listProduct.where((element) => element.idOrder==widget.mdDetail).toList();
    FetchDataPro();
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
                child: Text('${listOrder[index].idOrder}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa',
                        color: Colors.teal.shade700)),
              ),
              SizedBox(height: 15),
                   Container(
                     width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    
                       Text(
                            '${listOrder[0].state}!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                               ),
                          ),
                        
                        Text(
                          '${listOrder[0].statePayment}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                     
                   
                  ],
                ),
              ),
          SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                        Container(
                          child: Text(
                            '${listOrder[0].nameCus}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                               ),
                          ),
                        ),SizedBox(
                      height: 10,
                    ),
                        Text(
                          '${listOrder[0].phoneCus}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                     
                    SizedBox(
                      height: 10,
                    ),
                    Text('${listOrder[0].addressCus}', style: TextStyle(fontSize: 15))
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
                    itemCount: listProduct1.length,
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
                                              image: NetworkImage(
                                                  '${listProduct[index].imagePro}'),
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
                                            '${listProduct[index].namePro}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                              '${NumberFormat('###,###').format(int.parse( listProduct[index].price.toString()))}',
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
                                        Text('${listProduct[index].quantity}'),
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
                        Text('Đổi điểm  ', style: TextStyle(fontSize: 15)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Thanh Toán  ',
                            style: TextStyle(
                                fontSize: 16,
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
                            '${NumberFormat('###,###').format(int.parse(listOrder[0].totalPrice.toString()))}',
                            style: TextStyle(fontSize: 16)),
                        Text(
                            '${NumberFormat('###,###').format(int.parse(listOrder[0].costShip.toString()))}',
                            style: TextStyle(fontSize: 16)),
                        Text(
                            '-${NumberFormat('###,###').format(int.parse(listOrder[0].promotion.toString()))}',
                            style: TextStyle(
                                color: Colors.red.shade800, fontSize: 16)),
                                Text(
                            '-${NumberFormat('###,###').format(int.parse(listOrder[0].point.toString()))}',
                            style: TextStyle(
                                color: Colors.red.shade800, fontSize: 16)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            '${NumberFormat('###,###').format(int.parse(listOrder[0].totalPayment.toString()))}',
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
                padding: EdgeInsets.only(top: 20,bottom: 20,left: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mã đơn hàng: ${listOrder[0].idOrder}',
                      style: TextStyle(
                          color: Colors.teal.shade800,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    Text('Đặt hàng vào ngày  ${listOrder[0].date}',
                        style: TextStyle(color: Colors.grey.shade700,fontSize: 16)),
                        Text('Ngày dự kiến giao hàng ${listOrder[0].dateDelivery}',
                        style: TextStyle(fontSize: 16,color: Colors.grey.shade700)),
                    Text('Phương thức thanh toán: ${listOrder[0].payment}',
                        style: TextStyle(color: Colors.grey.shade700,fontSize: 16)),
                  ],
                ),
              ),
              button()
            ],
          ),
        ));
  }
   _dismissDialog() {
    Navigator.pop(context);
  }
  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hủy đặt hàng'),
            content: Text('Bạn có chắc là hủy đơn hàng ${listOrder[0].idOrder} ?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('Đóng')),
              TextButton(
                onPressed: () {
              setState(() {
                  FirListDetailOrder().updateOrder(listOrder[0].idOrder.toString()); 
                    Navigator.of(context).pop(MaterialPageRoute(
                                    builder: (context) => ListOrder()));
              });    
                 
                },
                child: Text('Đồng ý'),
              )
            ],
          );
        });
  }
  Widget button(){
    if(listOrder[0].state=='Chờ xác nhận')
              {
             
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: MaterialButton(
                    minWidth: 100,
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    color: Colors.red.shade700,
                    onPressed: ()  {
                  
                      setState(() {
                 
                  _showMaterialDialog();       
                       
                      });
                    },
                    child: Text(
                      'Hủy Đơn Hàng',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Lemonada'),
                    ),
                  ),
                )
              ]); }
              else{
               return Center(
                 heightFactor: 4,
                 child: Text('Không thể hủy đơn hàng',textAlign: TextAlign.center,),)
                 
                 ; 
              }
  }
}
