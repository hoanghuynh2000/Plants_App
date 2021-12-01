import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/firebase/detailorder.dart';
import 'package:plants_app/firebase/oder.dart';
import 'package:plants_app/firebase/promotion.dart';
import 'package:plants_app/firebase/shoppingcart.dart';
import 'package:plants_app/layoutdrawer.dart';
import 'package:plants_app/model/mdUser.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:plants_app/model/mddetailshoppingcart.dart';
import 'package:plants_app/model/mdpromotion.dart';
import 'package:plants_app/screens/home.dart';
import 'package:plants_app/screens/shoppingcart.dart';

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
  String state='Chờ xác nhận';
  bool cash=false;
  bool paymentOnl=false;

  
  
  
   String UID="";
  List<MDDetailShoppingCart> listPro = [
  
  ];
   FetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    UID = user!.uid;
  }
  List<MDUser> listUser=[];
  List<MDPromotion> listPromotion=[];
   FetchDataPromotion(String id)async{
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
}else
       print('unable');
    }
  }
 FetchDataShoppingCart()async{
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
         listUser=resultUser;
          listPro = result;
          diemThuong=int.parse(listUser[0].point.toString());
          for(int i=0;i<listPro.length;i++)
          {
            soluongtong=soluongtong+int.parse(listPro[i].quantity);
             int sotien= (int.parse(listPro[i].price))*int.parse(listPro[i].quantity);

                tongTien=tongTien+sotien;
          }
          
        });
}
      
    }
  }
  int diemThuong =0;
Widget DoiDiem(bool check ){
  if (check==true)
  {
    return Text("Đổi Điểm",style: TextStyle(fontSize: 15));
  }
  else{
    return Text('');
  }
}
  Widget Diem(bool check, int diem ){
  if (check==true)
  {
    return Text('-${NumberFormat('###,###').format(int.parse(diem.toString()))}',style: TextStyle(fontSize: 16));
  }
  else{
    return Text('');
  }
}
   int thanhToan=0 ;
  int soluongtong=0;
  int tongTien=0 ;
  int phiVanChuyen = 25000;
  
 final promotionController= new TextEditingController();
 String promotion='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchUserInfo();
    FetchDataShoppingCart();
    
  }
  Widget listViewPro(){
      
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16))
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
int giamGia=0 ;
  @override
  Widget build(BuildContext context) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd/MM/yyyy').format(now);
      String idOrder=DateFormat('yyyyMMddhhmmss').format(now)+UID.substring(0,5);
      
      int diemdoi=diemThuong * 100;
    double height = MediaQuery.of(context).size.height;
      
      if(status==true)
          thanhToan=tongTien+phiVanChuyen-giamGia-(diemThuong * 100);
          else
          thanhToan=tongTien+phiVanChuyen-giamGia;
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
                           )),
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
            listViewPro(),
            
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
                          onChanged: (value){
                            setState(() {
                              promotion=value;
                              FetchDataPromotion(promotion);
                            });
                          },
                          style: TextStyle(fontSize: 17),textAlign: TextAlign.start,
                            decoration: InputDecoration(focusColor: Colors.teal,
                            
                             focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                        Radius.circular(20)),
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade300),
                                        ),
                             prefixIcon:Icon( Icons.local_offer,color: Colors.teal.shade700,),
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
                          
                            if(listPromotion.isNotEmpty)
                            {
                            int phantram=int.parse(listPromotion[0].discount.toString()) ;
                          
                            giamGia=(tongTien*phantram)~/100 ;
                            if(giamGia>int.parse(listPromotion[0].discountMax.toString()))
                           {
                             giamGia=int.parse(listPromotion[0].discountMax.toString());
                           }
                            }else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mã giảm giá không tồn tại")));
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
                          Diem(status,diemdoi ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        
                        color: Colors.teal.shade900,
                      ),
                      Text('${NumberFormat('###,###').format(thanhToan)}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red.shade700)),
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
                              cash=true;
                              paymentOnl=false;
                            });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:cash?Colors.grey.shade400:Colors.white,
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Icon(Icons.payments_outlined),
                            SizedBox(width: 10,),
                            Text('Thanh toán tiền mặt',style: TextStyle(fontSize: 17)),],) 
                        ),
                      ),
                       SizedBox(
                    height: 5,
                  ),
                      InkWell(
                        onTap:(){
                          setState(() {
                            cash=false;
                            paymentOnl=true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:paymentOnl?Colors.grey.shade400:Colors.white,
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Image(image: AssetImage("./assets/images/paypal.png"),height:25,width: 350,),),
                    ),
                    
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
                        color: Colors.white, fontFamily: 'Comfortaa', fontSize: 18),
                  ),
                ),
                MaterialButton(
                  color: Colors.teal.shade900,
                  height: 40,
                  minWidth: 210,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  onPressed: () {
                    if(cash==false&&paymentOnl==false){
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vui lòng chọn phương thức thanh toán')));
                      
                   }else{
                    String payment='';
                    String statePayment='';
                    if(cash==true){
                      payment='Thanh toán khi nhận hàng';
                      statePayment='Chưa thanh toán';

                    }else if(paymentOnl==true){
                      payment='Paypal';
                      statePayment='Đã thanh toán';
                    }
                    if(status==false)
                    {
                      diemdoi=0;      
                      int diem=thanhToan~/10000 ;
                      diemThuong=diemThuong+diem;
                      FirListOder().updateDiem(diemThuong);
                    }
                    else{
                      int diem=thanhToan~/10000 ;
                      diemThuong=0;
                      diemThuong=diemThuong+diem;
                       FirListOder().updateDiem(diemThuong);
                    }
                 
                    for(int i=0;i<listPro.length;i++){
                      String idPro=listPro[i].idProduct;
                      //String totalPrice= (int.parse(listPro[i].price)*int.parse(listPro[i].quantity)).toString();
                      FirListDetailOrder().addListDetailOrder(UID, listPro[i].quantity, listPro[i].price, idOrder, idPro, listPro[i].images, listPro[i].productName);
                }
    
                    FirListOder().addListOrder(UID, nameCus, phoneCus, addressCus, idOrder, state, formattedDate, '',
                    giamGia.toString(), diemdoi.toString(), payment, soluongtong.toString(), 
                    thanhToan.toString(), statePayment, phiVanChuyen.toString(), tongTien.toString());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đặt hàng thành công')));
                    FirShoppingCart().removeProductorder();
                    Navigator.of(context).pop(MaterialPageRoute(
                                    builder: (context) => ShoppingCart()));
                      
                }},
                  child: Text(
                    'Xác Nhận Thanh Toán',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, fontFamily: 'Comfortaa'),
                  ),
                ),
              ],
            ))
          ]),
        )));
  }
}
