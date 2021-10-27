import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/fake/fakelistorder.dart';
import 'package:plants_app/fake/productfake.dart';
import 'package:plants_app/model/mdorder.dart';
import 'package:plants_app/model/mddetailorder.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:plants_app/screens/detailsorder.dart';
class ListOrder extends StatefulWidget {
  ListOrder({Key? key}) : super(key: key);

  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  final controller = PageController();
 
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Đơn hàng của tôi'),
        backgroundColor: Colors.teal.shade900,
       ),
      body:
     DefaultTabController(
  length: 6,
  child: Column(
    children: <Widget>[
      ButtonsTabBar(
        radius: 12,
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        
        borderColor: Colors.transparent,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.teal.shade800,
             Colors.teal.shade700,
              Colors.teal.shade500,
            ],
          ),
        ),
        unselectedBackgroundColor: Colors.white,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(color: Colors.white),
        height: 56,
        tabs: [
           Tab(
                    icon: Icon(Icons.list),
                    text: "Tất cả",
                  ),
                  Tab(
                    icon: Icon(Icons.schedule),
                    text: "Chờ xác nhận",
                  ),
                  Tab(
                    icon: Icon(Icons.task_alt),
                    text: "Đã xác nhận",
                  ),
                  Tab(
                    icon: Icon(Icons.delivery_dining),
                    text: "Đang giao hàng",
                  ),
                  Tab(
                    icon: Icon(Icons.cases_outlined),
                    text: "Giao hàng thành công",),
                  Tab(icon: Icon(Icons.cancel_presentation),
                    text: "Đã hủy",),
                  
                ],
      ),
      Expanded(
        child: TabBarView(
          children: <Widget>[
            Container(
                      child: All(),
                    ),
                    Container(
                      child:ChoXacNhan(),
                    ),
                   Container(
                      child:DaXacNhan(),
                    ),
                    Container(
                      child:DangGiaoHang(),
                    ),
                    Container(
                      child:GiaoThanhCong(),
                    ),
                    Container(
                      child:DaHuy(),
                    ),
                   
                  ],
        ),
      ),
    ],
  ),
)
        );
  }
}
Widget All(){
  String? idOrder;
  String? state;
  String? date;
  String image="assets/images/caydemo.png";
  int soLuong=2;
  int total=0;
  List<mdOrder> listOrder=fakeListOrder.toList();
  late List<mdDetailOrder> listDetailOrder=[mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,),
  mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,)];//
  List<DetailProduct>listPro=FakeProduct.toList();
   return Item(listOrder, listPro);
          
         
}
Widget DaHuy(){
  String? idOrder;
  String? state;
  String? date;
  String image="assets/images/caydemo.png";
  int soLuong=2;
  int total=0;
  List<mdOrder> listOrder=fakeListOrder.where((element) => element.state=='Đã hủy').toList();
  late List<mdDetailOrder> listDetailOrder=[mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,),
  mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,)];//
  List<DetailProduct>listPro=FakeProduct.toList();
   return Item(listOrder, listPro);
          
         
}

Widget GiaoThanhCong(){
  String? idOrder;
  String? state;
  String? date;
  String image="assets/images/caydemo.png";
  int soLuong=2;
  int total=0;
  List<mdOrder> listOrder=fakeListOrder.where((element) => element.state=='Giao thành công').toList();
  late List<mdDetailOrder> listDetailOrder=[mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,),
  mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,)];//
  List<DetailProduct>listPro=FakeProduct.toList();
   return Item(listOrder, listPro);
          
         
}

Widget DangGiaoHang(){
  String? idOrder;
  String? state;
  String? date;
  String image="assets/images/caydemo.png";
  int soLuong=2;
  int total=0;
  List<mdOrder> listOrder=fakeListOrder.where((element) => element.state=='Đang giao hàng').toList();
  late List<mdDetailOrder> listDetailOrder=[mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,),
  mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,)];//
  List<DetailProduct>listPro=FakeProduct.toList();
   return Item(listOrder, listPro);
          
         
}

Widget DaXacNhan(){
  String? idOrder;
  String? state;
  String? date;
  String image="assets/images/caydemo.png";
  int soLuong=2;
  int total=0;
  List<mdOrder> listOrder=fakeListOrder.where((element) => element.state=='Đã xác nhận').toList();
  late List<mdDetailOrder> listDetailOrder=[mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,),
  mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,)];//
  List<DetailProduct>listPro=FakeProduct.toList();
   return Item(listOrder, listPro);
          
         
}

Widget ChoXacNhan(){
  String? idOrder;
  String? state;
  String? date;
  String image="assets/images/caydemo.png";
  int soLuong=2;
  int total=0;
  List<mdOrder> listOrder=fakeListOrder.where((element) => element.state=='Chờ xác nhận').toList();
  late List<mdDetailOrder> listDetailOrder=[mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,),
  mdDetailOrder(idDetailOrder: '12345',idDetailShopping: '123',idOrder: '1223',idPro: '123456',quantity: 2,totalPrice: 140000,)];//
  List<DetailProduct>listPro=FakeProduct.toList();
   return Item(listOrder, listPro);
          
         
}
Stack Item( List listOrder, List listPro){
  return Stack(
          children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: listOrder.length,
                itemBuilder: (context,index){
                return  InkWell(
                   onTap: (){
        Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>DetailsOrder(mdDetail: listOrder[index].idOrder))
        );
      }
      ,
      child:Container(
                  margin: EdgeInsets.only(left: 15,right: 15,top: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(color:Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 220,
                            child:  Text('Mã đơn hàng: ${listOrder[index].idOrder}',style: TextStyle(fontSize: 17,color: Colors.teal.shade800,fontWeight: FontWeight.bold),),
                         
                          ),
                          Text('${listOrder[index].state}',style:TextStyle(fontSize:16,color: Colors.grey.shade600))

                          
                        ],
                      ),
                       ListView.builder(
               scrollDirection: Axis.vertical,
               shrinkWrap: true,
                itemCount: listPro.length, 
                itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: 5,right: 5),
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
                      image:DecorationImage(
                        image:AssetImage('${listPro[index].imgProduct}'),
                        fit: BoxFit.cover ) ),
                  ), SizedBox(width: 35,),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${listPro[index].namePro}',
                      style: TextStyle(fontSize: 16,),),
                     
                      Text('${NumberFormat('###,###').format(listPro[index].pricePro)}',
                      style: TextStyle(color: Colors.red,fontSize: 16))
                    ],
                  ),Expanded(child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${listPro[index].quantity}'),
                      SizedBox(width: 15,)
                    ],
                  ))
                ]),
                Padding(
          padding:EdgeInsets.symmetric(horizontal:10.0),
          child:Container(
            height:1.0,
            width:250.0,
            color:Colors.grey.shade300,),),
                ],
              )
            );
          }    ),
          SizedBox(height: 15,),
                     Row(
                       
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Text('${listOrder[index].date}'),
                          Text('Tổng tiền: ${NumberFormat('###,###').format(listOrder[index].totalPrice)}',
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                          
                        ],
                      )
                    ],
                  ),
                )
             
                );  })
          ],
        
 
      
     
      );
}
