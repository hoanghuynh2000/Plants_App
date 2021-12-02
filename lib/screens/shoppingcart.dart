import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/firebase/product.dart';
import 'package:plants_app/firebase/shoppingcart.dart';
import 'package:plants_app/handle/cartcounter.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/model/mddetailshoppingcart.dart';
import 'package:plants_app/screens/order.dart';
import 'package:plants_app/screens/product.dart';

import '../layoutdrawer.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<MDDetailShoppingCart> listPro = [
   
  ];
 TextEditingController? countController;
  int count=1;
   String UID="";
      List<DetailProduct> listProduct= [];
   FetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if(user!=null)
    UID = user.uid;
  }
    FetchDataPro()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); 
    dynamic result = await DataProduct().getAllProductList();
     //dynamic resultPro = await DataProduct().getCateProductList(widget.detailProduct.idCate);
    if (result == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
        
          listProduct = result;
        });
}
      
    }
  }
  
  FetchDataShoppingCart()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); 
    dynamic result = await FirShoppingCart().getListShoppingCart(UID);
     //dynamic resultPro = await DataProduct().getCateProductList(widget.detailProduct.idCate);
    if (result == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
        
          listPro = result;
        });
}
      
    }
  }
  @override
  void dispose() {
    FetchDataShoppingCart();
    // TODO: implement dispose
    super.dispose();
    
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchDataShoppingCart();
    FetchUserInfo();
     FetchDataPro();
  }

  int TinhTien(List<MDDetailShoppingCart> listPro){
    FetchDataShoppingCart();
   
    int tongPro=0;
    int tongCong=0;
    for(int i=0;i<listPro.length;i++)
    {
      int tienPro= int.parse(listPro[i].price);
      int slPro=int.parse(listPro[i].quantity);
      tongPro=tienPro*slPro;
      tongCong=tongCong+tongPro;
    }
    return tongCong;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    if(listPro.length>0)
                  {
    return  SafeArea(
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
                       // FetchDataPro(listPro[index].idProduct);
                         int dem=int.parse(listPro[index].quantity);
                         
                          final item= listPro[index];
                          
                          void remove(BuildContext context) {
                      FirShoppingCart().removeProduct(listPro[index].idProduct);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sản phẩm đã được xóa khỏi giỏ hàng')));
                            }
                            void doNotThing(BuildContext context) {
                      
                            }
                          return  Slidable(
                            endActionPane: ActionPane(
                          motion: DrawerMotion(),
                          children: [
                  
                              SlidableAction(
                                autoClose: true,
                                flex: 1,
                                onPressed:remove,
                                backgroundColor: Color(0xFFF74933),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Xóa',
                  ),
                 
                             SlidableAction(
                    // An action can be bigger than the others.
                              flex: 1,
                              onPressed:doNotThing,
                              backgroundColor: Color(0xFF035C3A),
                              foregroundColor: Colors.white,
                              icon: Icons.close,
                              label: 'Đóng',

                  ),
                ],
              ),
 
                            child:  ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      leading:CircleAvatar(radius: 30,backgroundColor: Colors.teal.shade400,
      backgroundImage: NetworkImage(item.images),) ,
      title:Row(children: [Container(
                                  width: 190,
                                  child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.productName}',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      '${item.categoryName}',
                                      style: TextStyle(
                                          color: Colors.teal.shade500),
                                    ),
                                    Text(
                                        '${NumberFormat('###,###').format(int.parse(item.price.toString()))}',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 17))
                                  ],
                                ),
                               
                                ),
                                 Container(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Container(
                 child: 
           Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                   margin: EdgeInsets.only(right: 18),
                  width: 20,
                  child: IconButton(
                      onPressed: () {
                       
                        setState(() {
                         
                          if(dem>1){
                            dem=dem-1;
                         FirShoppingCart().updateProduct(listPro[index].idProduct,dem.toString());
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vui lòng chọn số lượng lớn hơn 1')));
                          }
                          
                        });
                      },
                      icon: Icon(Icons.remove)),
                ),
                Container(
                    width: 20,
                    // ignore: unnecessary_brace_in_string_interps
                    child: Text(
                      '${listPro[index].quantity}',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    )),
                Container(
                  width: 20,
                  child: IconButton(
                      onPressed: () {
                
                        setState(() {
                          List<DetailProduct>listDtail=[];
                          listDtail=listProduct.where((element) => element.id== listPro[index].idProduct).toList();
                          print(listPro[index].idProduct);
                         if(dem<20){
                           
                           if(int.parse(listPro[index].quantity) >= int.parse(listDtail[0].quantity)){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Số lượng chỉ còn ${listDtail[0].quantity}')));
                            }
                         else{
                           dem=dem+1;
                            
                         FirShoppingCart().updateProduct(listPro[index].idProduct,dem.toString());
                       
                         }
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Mua số lượng lớn vui lòng liên hệ cửa hàng để biết thêm thông tin')));
                        }});
                      },
                      icon: Icon(Icons.add)),
                )
              ],
            ))
             )
                                        ],
                                      ),
                                    ))
                              ,]),
                                onTap: (){},
                                
    )
 )
                          ;
                          
                        }, )),
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
                                  '${NumberFormat('###,###').format(TinhTien(listPro))}',
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
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Order()));
                              },
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
                ]))));}else{
                  return  SafeArea(
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
            body:Center(
              
              child: Text('Giỏ hàng chưa có sản phẩm',textAlign: TextAlign.center,style: TextStyle(fontSize: 18),)),));
                }
  }
  
  // Widget buildListTitle(MDDetailShoppingCart mdDetailShoppingCart){
  //  return }
}
