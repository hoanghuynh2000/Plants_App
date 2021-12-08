import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/colorsize/gradienticon.dart';
import 'package:plants_app/colorsize/gradienttext.dart';
import 'package:plants_app/fake/fakelistorder.dart';
import 'package:plants_app/fake/productfake.dart';
import 'package:plants_app/firebase/detailorder.dart';
import 'package:plants_app/firebase/feedback.dart';
import 'package:plants_app/firebase/oder.dart';
import 'package:plants_app/firebase/product.dart';
import 'package:plants_app/model/mdfeedback.dart';
import 'package:plants_app/model/mdorder.dart';
import 'package:plants_app/model/mddetailorder.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:plants_app/screens/addfeedback.dart';
import 'package:plants_app/screens/detailfeedback.dart';
import 'package:plants_app/screens/detailsorder.dart';

class ListOrder extends StatefulWidget {
  ListOrder({Key? key}) : super(key: key);

  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  final controller = PageController();
  String UID = "";
  List<mdDetailOrder> listProduct = [];
  List<mdOrder> listOrder = [];
  List<MDFeedback> listFeed = [];
  FetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    UID = user!.uid;
  }

  List<DetailProduct> listProductFeed = [];
  FetchProduct(String id) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic resultPro = await DataProduct().getProductIdList(id);

    if (resultPro == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          listProductFeed = resultPro;
        });
      }
    }
  }

  FetchDataPro() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await FirListOder().getListOrder(UID);
    dynamic resultPro = await FirListDetailOrder().getListDetailOrder();

    if (result == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          listOrder = result;
          listProduct = resultPro;
        });
      }
    }
  }

  FetchDataFeed() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic resultFeed = await FirFeedback().getListFeedback();
    if (resultFeed == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          listFeed = resultFeed;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchUserInfo();
    FetchDataPro();
    FetchDataFeed();
  }

  @override
  Widget build(BuildContext context) {
    FetchDataPro();
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
          title: Text('Đơn hàng của tôi'),
          backgroundColor: Colors.teal.shade900,
        ),
        body: DefaultTabController(
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
                    text: "Giao hàng thành công",
                  ),
                  Tab(
                    // child: Container(
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.cancel_presentation,
                    //           color: Colors.teal.shade900),
                    //       SizedBox(width: 10),
                    //       GradientText(
                    //         "Đã hủy",
                    //         gradient: LinearGradient(
                    //           colors: <Color>[
                    //             Colors.teal.shade900,
                    //             Colors.teal.shade700,
                    //             Colors.teal.shade600,
                    //           ],
                    //         ),
                    //         style: TextStyle(fontSize: 16),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    icon: Icon(Icons.cancel_presentation),
                    text: "Đã hủy",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Container(
                      child: All(),
                    ),
                    Container(
                      child: ChoXacNhan(),
                    ),
                    Container(
                      child: DaXacNhan(),
                    ),
                    Container(
                      child: DangGiaoHang(),
                    ),
                    Container(
                      child: GiaoThanhCong(),
                    ),
                    Container(
                      child: DaHuy(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget All() {
    return Item(listOrder, listProduct);
  }

  Widget DaHuy() {
    List<mdOrder> listOrder1 =
        listOrder.where((element) => element.state == 'Đã hủy').toList();
    FirListDetailOrder().getListDetailOrder();

    return Item(listOrder1, listProduct);
  }

  Widget GiaoThanhCong() {
    List<mdOrder> listOrder1 = listOrder
        .where((element) => element.state == 'Giao thành công')
        .toList();

    return Item(listOrder1, listProduct);
  }

  Widget DangGiaoHang() {
    List<mdOrder> listOrder1 = listOrder
        .where((element) => element.state == 'Đang giao hàng')
        .toList();

    return Item(listOrder1, listProduct);
  }

  Widget DaXacNhan() {
    List<mdOrder> listOrder1 =
        listOrder.where((element) => element.state == 'Đã xác nhận').toList();

    return Item(listOrder1, listProduct);
  }

  Widget ChoXacNhan() {
    List<mdOrder> listOrder1 =
        listOrder.where((element) => element.state == 'Chờ xác nhận').toList();

    List<DetailProduct> listPro = FakeProduct.toList();
    return Item(listOrder1, listProduct);
  }

  Widget ButtonFeed(
      int index, int indexsp, List listProduct1, List listOrder1) {
    if (listOrder1[index].state == 'Giao thành công' &&
        listProduct1[indexsp].state == 'Chưa đánh giá') {
      return MaterialButton(
        hoverColor: Colors.redAccent,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddFeedback(listOrder1[index].idOrder,
                  listProduct1[indexsp].idPro.toString())));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.red)),
        child: Text(
          'Đánh giá',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
      );
    } else if (listOrder1[index].state == 'Giao thành công' &&
        listProduct1[indexsp].state == 'Đã đánh giá') {
      return MaterialButton(
        minWidth: 100,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailFeedback(listOrder1[index].idOrder,
                  listProduct1[indexsp].idPro.toString())));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.teal.shade800)),
        child: Text(
          'Xem đánh giá',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.teal.shade800, fontSize: 12),
        ),
      );
    } else {
      return Text('${listProduct1[indexsp].quantity}');
    }
  }

  Stack ItemListFeedback() {
    return Stack(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: listOrder.length,
            itemBuilder: (context, index) {
              FetchProduct(listFeed[index].idSanPham.toString());
              return Container(
                child: Row(
                  children: [
                    ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal.shade400,
                        backgroundImage:
                            NetworkImage(listProductFeed[0].imgProduct),
                      ),
                      title: Row(children: [
                        Container(
                          width: 190,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${listProductFeed[0].namePro}',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                '${listProductFeed[0].idCate}',
                                style: TextStyle(color: Colors.teal.shade500),
                              ),
                              Text(
                                  '${NumberFormat('###,###').format(int.parse(listProductFeed[0].pricePro.toString()))}',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 17))
                            ],
                          ),
                        ),
                      ]),
                      onTap: () {},
                    )
                  ],
                ),
              );
            })
      ],
    );
  }

  Stack Item(List<mdOrder> listOrder, List<mdDetailOrder> listPro) {
    int indexOrder;

    return Stack(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: listOrder.length,
            itemBuilder: (context, index) {
              indexOrder = index;
              String idOrder = listOrder[index].idOrder.toString();

              List<mdDetailOrder> listProduct1 = listPro
                  .where(
                      (element) => element.idOrder == listOrder[index].idOrder)
                  .toList();
              return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsOrder(mdDetail: idOrder)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                'Mã đơn hàng: ${listOrder[index].idOrder}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.teal.shade800,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text('${listOrder[index].state}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey.shade600))
                          ],
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: listProduct1.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          '${listProduct1[index].imagePro}'),
                                                      fit: BoxFit.cover)),
                                            ),
                                            SizedBox(
                                              width: 25,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${listProduct1[index].namePro}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                      '${NumberFormat('###,###').format(int.parse(listProduct1[index].price.toString()))}',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 16))
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  ButtonFeed(indexOrder, index,
                                                      listProduct1, listOrder)
                                                ],
                                              ),
                                            )
                                          ]),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Container(
                                          height: 1.0,
                                          width: 250.0,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    ],
                                  ));
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${listOrder[index].date}'),
                            Text(
                              'Tổng tiền: ${NumberFormat('###,###').format(int.parse(listOrder[index].totalPayment.toString()))}',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
            })
      ],
    );
  }
}
