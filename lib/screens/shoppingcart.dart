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

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<MDDetailShoppingCart> listPro = [
   
  ];
   String UID="";
   FetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    UID = user!.uid;
  }
  FetchDataShoppingCart()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); 
    dynamic result = await FirShoppingCart().getListShoppingCart(UID);
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        listPro = result;
      });
    }
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchDataShoppingCart();
    FetchUserInfo();
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
                          final item= listPro[index];
                          return  Slidable(
                            endActionPane: ActionPane(
                motion: DrawerMotion(),
                children: [
                  
                     SlidableAction(
                       autoClose: true,
                    // An action can be bigger than the others.
                    flex: 1,
                    onPressed:doNothing,
                    backgroundColor: Color(0xFFF74933),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Xóa',
                  ),
                 
                  
                  
                     SlidableAction(
                    // An action can be bigger than the others.
                    flex: 1,
                    onPressed:doNothing,
                    backgroundColor: Color(0xFF035C3A),
                    foregroundColor: Colors.white,
                    icon: Icons.close,
                    label: 'Đóng',
                  ),
                ],
              ),
 
                            child: buildListTitle(item))
                          ;
                          // Container(
                          //   margin:
                          //       EdgeInsets.only(top: 10, left: 10, right: 10),
                          //   padding: EdgeInsets.all(15),
                          //   decoration: BoxDecoration(
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(20)),
                          //     color: Colors.white,
                          //   ),
                          //   child: 
                          //   Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     children: [
                          //       Container(
                          //         height: 60,
                          //         width: 60,
                          //         decoration: BoxDecoration(
                          //             image: DecorationImage(
                          //                 image: NetworkImage(listPro[index].images),
                          //                 fit: BoxFit.cover)),
                          //       ),
                          //       SizedBox(
                          //         width: 15,
                          //       ),
                                
                          //       SizedBox(
                          //         width: 25,
                          //       ),
                          //       Container(
                          //           alignment: Alignment.centerRight,
                          //           child: CartCounter())
                          //     ],
                          //   ),
                          
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
            body:Text('Giỏ hàng chưa có sản phẩm')));
                }
  }
  void doNothing(BuildContext context) {}
  Widget buildListTitle(MDDetailShoppingCart mdDetailShoppingCart){
   return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      leading: CircleAvatar(radius: 30,
      backgroundImage: NetworkImage(mdDetailShoppingCart.images),),
      title:Row(children: [Container(
                                  width: 190,
                                  child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${mdDetailShoppingCart.productName}',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      '${mdDetailShoppingCart.categoryName}',
                                      style: TextStyle(
                                          color: Colors.teal.shade500),
                                    ),
                                    Text(
                                        '${NumberFormat('###,###').format(int.parse(mdDetailShoppingCart.price.toString()))}',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 17))
                                  ],
                                ),
                               
                                ),
                                 Container(
                                    alignment: Alignment.centerRight,
                                    child: CartCounter())
                              ,]),
                                onTap: (){},
                                
    );
  }
}
