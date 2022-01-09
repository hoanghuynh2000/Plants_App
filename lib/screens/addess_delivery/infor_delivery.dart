// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:plants_app/firebase/address.dart';
import 'package:plants_app/handle/refresh.dart';
import 'package:plants_app/model/mdAddress.dart';
import 'package:plants_app/screens/addess_delivery/UpdateAddress.dart';
import 'package:plants_app/screens/addess_delivery/add_delivery.dart';
import 'package:plants_app/screens/order.dart';

class InforDelivery extends StatefulWidget {
  InforDelivery({Key? key}) : super(key: key);

  @override
  _InforDeliveryState createState() => _InforDeliveryState();
}

class _InforDeliveryState extends State<InforDelivery> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();

  List<MDAddress> address = [];
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  List<int> dataload = [];
  final GlobalKey<RefreshIndicatorState> key =
      new GlobalKey<RefreshIndicatorState>();
  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 3000));

    final random = Random();
    final data = List.generate(100, (_) => random.nextInt(100));
    if (this.mounted) {
      setState(() => this.dataload = data);
    }
  }

  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await AddressFirebase().getAddressList();
    if (result == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          address = result;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchData();
  }

  @override
  Widget build(BuildContext context) {
    FetchData();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Địa chỉ giao hàng'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Colors.teal.shade900,
              Colors.teal.shade600
            ])),
          ),
          elevation: 0,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                height: 70,
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(
                          color: Colors.teal.shade900,
                          style: BorderStyle.solid,
                          width: 1),
                    ),
                    textColor: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddDelivery()));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_location_alt_outlined,
                            color: Colors.teal.shade900,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Thêm địa chỉ mới',
                            style: TextStyle(color: Colors.teal.shade900),
                          ),
                        ])),
              ),
              Expanded(
                  child: RefreshWidget(
                      onRefresh: loadList,
                      key: key,
                      keyRefresh: keyRefresh,
                      child: listAddress()))
            ],
          ),
        ),
      ),
    );
  }

  Widget listAddress() {
    return ListView.builder(
        itemCount: address.length,
        itemBuilder: (context, index) {
          void remove(BuildContext context) {
            AddressFirebase().DeleteAddress(address[index].idAddress!);
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Địa chỉ đã được xóa')));
          }

          void doNotThing(BuildContext context) {}
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Slidable(
                endActionPane: ActionPane(
                  motion: DrawerMotion(),
                  children: [
                    SlidableAction(
                      autoClose: true,
                      flex: 1,
                      onPressed: remove,
                      backgroundColor: Color(0xFFF74933),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Xóa',
                    ),
                    SlidableAction(
                      // An action can be bigger than the others.
                      flex: 1,
                      onPressed: doNotThing,
                      backgroundColor: Color(0xFF035C3A),
                      foregroundColor: Colors.white,
                      icon: Icons.close,
                      label: 'Đóng',
                    ),
                  ],
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Order(
                                    idAddress: address[index].idAddress,
                                  )));
                    },
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address[index].name!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                address[index].phonenumber!,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                address[index].street!,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(address[index].address!,
                                  overflow: TextOverflow.ellipsis, maxLines: 1)
                            ],
                          )),
                          IconButton(
                              icon: Icon(
                                Icons.edit_location_outlined,
                                color: Colors.teal.shade700,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateAddress(
                                              id: address[index].idAddress,
                                              name: address[index].name,
                                              phone: address[index].phonenumber,
                                            )));
                              })
                        ],
                      ),
                    )),
              ),
              Divider(
                color: Colors.black,
              )
            ],
          );
        });
  }
}
