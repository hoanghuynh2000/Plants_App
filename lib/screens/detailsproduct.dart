import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/bloc/CouterBloc.dart';
import 'package:plants_app/couter/event.dart';
import 'package:plants_app/fake/feedfake.dart';
import 'package:plants_app/firebase/feedback.dart';
import 'package:plants_app/firebase/firebaseservice.dart';
import 'package:plants_app/firebase/product.dart';
import 'package:plants_app/handle/favorite.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/model/mddetailshoppingcart.dart';
import 'package:plants_app/model/mdfavorites.dart';
import 'package:plants_app/model/mdfeedback.dart';
import 'package:plants_app/screens/shoppingcart.dart';
import 'package:plants_app/firebase/shoppingcart.dart';

import 'detailproduct/itemproduct.dart';

class DetailsProduct extends StatefulWidget {
  DetailProduct detailProduct;
  DetailsProduct({required this.detailProduct});
  @override
  _DetailsProductState createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  String UID = "";
  List<MDFeedback> mdFeedback = [];
  FetchFeed() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    dynamic result = await FirFeedback()
        .getListFeedbackPro(widget.detailProduct.id.toString());
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        mdFeedback = result;
      });
    }
  }

  List<MDDetailShoppingCart> listShopping = [];
  FetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      UID = user.uid;
    }
  }

  List<DetailProduct> listPro = [];

  FetchDataPro() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result =
        await DataProduct().getCateProductList(widget.detailProduct.idCate);
    dynamic resultshopping = await FirShoppingCart().getListShoppingCart(UID);
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        listPro = result;
        listShopping = resultshopping;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchUserInfo();
    FetchDataPro();
    FetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    String? id = widget.detailProduct.id;
    FirebaseServices _firebaseServices = FirebaseServices();
    String _selectedQuantity = "0";

    FirShoppingCart firShoppingCart = new FirShoppingCart();

    int isImportant = 0;
    String? idProduct = widget.detailProduct.id;
    String? productName = widget.detailProduct.namePro;
    String? categoryName = widget.detailProduct.idCate;
    dynamic price = widget.detailProduct.pricePro;
    String? images = widget.detailProduct.imgProduct;
    String? idFav = idProduct;
    String? descript = widget.detailProduct.descrip;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Favorites favorites = new Favorites(
        id: idFav,
        isImportant: isImportant,
        idProduct: idProduct,
        productName: productName,
        categoryName: categoryName,
        price: price,
        images: images);

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0.0, 0.0),
                colors: [Color(0xFF009688), Color(0xFFffffff)])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            persistentFooterButtons: <Widget>[
              Container(
                  //decoration:BoxDecoration(color: Colors.white),
                  child: Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  //nút Yêu thích.
                  FavIcon(favorites),
                  SizedBox(
                    width: 40,
                  ),
                  if (int.parse(widget.detailProduct.quantity) > 0) ...[
                    MaterialButton(
                      onPressed: () {
                        if (UID.isNotEmpty) {
                          firShoppingCart.addToShoppingCart(UID, idProduct!,
                              productName!, price, categoryName!, images!);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Thêm vào giỏ hàng thành công')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Vui lòng đăng nhập')));
                        }
                      },
                      child: Text('Thêm Vào Giỏ Hàng',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rokkitt',
                              fontSize: 24)),
                      color: Colors.teal.shade800,
                      height: 50,
                      minWidth: width * 0.6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  ] else ...[
                    MaterialButton(
                      onPressed: () {},
                      child: Text('Hết hàng',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rokkitt',
                              fontSize: 24)),
                      color: Colors.red.shade800,
                      height: 50,
                      minWidth: width * 0.6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  ]
                ],
              ))
            ],
            // each product have a color
            //backgroundColor:Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors:[Color(Colors.blue),Color(Colors.white)])),) ,
            appBar: buildAppBar(context),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: height * 0.25),
                        padding: EdgeInsets.only(
                          top: height * 0.05,
                        ),
                        //height: height / 1.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: width / 2.2,
                                child: Text(
                                  '${productName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                ),
                              ),

                              SizedBox(height: 10),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${NumberFormat('###,###').format(int.parse(price))} VND',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                                child: Divider(color: Colors.black),
                              ),
                              SizedBox(height: 10),
                              //                          CartCounter(_selectedQuantity),
                              Text(
                                'Mô Tả Sản Phẩm',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal.shade900,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Container(
                                  width: width,
                                  padding: EdgeInsets.all(15),
                                  //margin:EdgeInsets.only(left: 5,right: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${categoryName}',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Text("${descript}",
                                          style: TextStyle(
                                            fontSize: 17,
                                          )),
                                    ],
                                  )),

                              SizedBox(height: 20),
                              Text(
                                'Đánh Giá Sản Phẩm',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal.shade900,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 300),
                                child: Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: mdFeedback.length,
                                      itemBuilder: (context, index) {
                                        if (mdFeedback.isNotEmpty) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30)),
                                                            image:
                                                                DecorationImage(
                                                                    image:
                                                                        NetworkImage(
                                                                      '${mdFeedback[index].anhKhachHang}',
                                                                    ),
                                                                    fit: BoxFit
                                                                        .fill),
                                                          ),
                                                          height: 40,
                                                          width: 40,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                            width: width / 2,
                                                            height: 20,
                                                            child: Text(
                                                              '${mdFeedback[index].tenKhachHang}',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                        Container(
                                                            width: width * 0.2,
                                                            child: Text(
                                                              '${mdFeedback[index].ngay}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey
                                                                    .shade700,
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                            width: width * 0.8,
                                                            child: Text(
                                                                '${mdFeedback[index].noiDung}')),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Text(
                                            'Chưa có đánh giá',
                                            textAlign: TextAlign.center,
                                          );
                                        }
                                      }),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Gợi ý',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal.shade900,
                                    fontWeight: FontWeight.bold),
                              ),

                              //SizedBox(height: 10),
                              Container(
                                height: 250,
                                child: _buildNewProduct(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width / 2.5,
                          ),
                          Expanded(
                            child: Hero(
                                tag: "${id}",
                                child: Column(
                                  children: [
                                    Image.network(
                                      '${widget.detailProduct.imgProduct}',
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      //margin: EdgeInsets.only(left: 15),
                                      height: 10,
                                      width: 140,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        stops: [
                                          0,
                                          0.4,
                                          0.8,
                                        ],
                                        colors: [
                                          Colors.white,
                                          Colors.grey.shade400,
                                          Colors.white,
                                        ],
                                      )),
                                    )
                                  ],
                                )),
                            // SizedBox(
                            //   width: ,
                            // ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )));
  }

  Widget _buildNewProduct() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.only(top: 10),
              height: 320,
              child: ItemProduct(detailProduct: listPro[index]));
        },
        itemCount: listPro.length);
  }

  //AppBar chi tiết sản phẩm
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal.shade400,
      elevation: 0,
      actions: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12.0, right: 20.0),
              child: InkResponse(
                onTap: () {
                  if (UID.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ShoppingCart(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Vui lòng đăng nhập')));
                  }
                },
                child: Icon(
                  Icons.shopping_basket,
                  size: 40.0,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              bottom: 8.0,
              right: 16.0,
              child: Container(
                height: 20.0,
                width: 20.0,
                decoration: BoxDecoration(
                  color: Colors.teal.shade800,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    '${listShopping.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

// class Feedback extends StatelessWidget {
//   String idpro;
//   Feedback(this.idpro);

//   @override
//   Widget build(BuildContext context) {
//      FetchFeed();
//       double width = MediaQuery.of(context).size.width;
//     return
//   }
// }

// class ItemFeedback extends StatelessWidget {
//   MDFeedback mdFeedback = new MDFeedback();
//   ItemFeedback({required this.mdFeedback});
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Container(
//       padding: EdgeInsets.only(top: 5, bottom: 5),
//       margin: EdgeInsets.only(top: 5, bottom: 5),
//       decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.all(Radius.circular(15))),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 10,
//           ),
//           Column(
//             children: [
//               SizedBox(
//                 width: 10,
//               ),
//               Row(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(40)),
//                       image: DecorationImage(
//                           image: NetworkImage(
//                             '${mdFeedback.anhKhachHang}',
//                           ),
//                           fit: BoxFit.fill),
//                     ),
//                     height: 40,
//                     width: 40,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                       width: width / 2,
//                       height: 20,
//                       child: Text(
//                         '${mdFeedback.tenKhachHang}',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       )),
//                   Container(
//                       width: width * 0.2,
//                       child: Text(
//                         '${mdFeedback.ngay}',
//                         textAlign: TextAlign.right,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey.shade700,
//                         ),
//                       ))
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                   width: width * 0.8, child: Text('${mdFeedback.noiDung}')),
//               SizedBox(
//                 height: 10,
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }

// }

SizedBox buildOutlineButton({required IconData icon, required Function press}) {
  return SizedBox(
    width: 40,
    height: 32,
    // ignore: deprecated_member_use
    child: OutlineButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      onPressed: () {
        press;
      },
      child: Icon(icon),
    ),
  );
}
