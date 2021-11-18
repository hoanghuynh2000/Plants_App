import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:plants_app/firebase/product.dart';
import 'package:plants_app/handle/refresh.dart';
import 'package:plants_app/model/mdcategory.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/screens/itemgridviewproduct.dart';

class Product extends StatefulWidget {
  Product({Key? key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> key =
      new GlobalKey<RefreshIndicatorState>();
  bool _isSeclected = true;
  int _selectedIndex = -1;
  List<int> dataload = [];
  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 4000));

    final random = Random();
    final data = List.generate(100, (_) => random.nextInt(100));
    if (this.mounted) {
      setState(() => this.dataload = data);
    }
  }

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  late Color colorCate = Colors.teal.shade700;
  List<Category> listCate = [];

  List<DetailProduct> _list = [];

  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await DataProduct().getAllProductList();
    dynamic category = await DataProduct().getAllCategory();
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        _list = result;
        _foundProduct = result;
        listCate = category;
      });
    }
  }

  List<DetailProduct> _foundProduct = [];
  @override
  void initState() {
    _foundProduct = _list;
    super.initState();
    FetchData();
  }

  void _FilterPro(String nameCate) {
    setState(() {
      _foundProduct = _list.where((e) => e.idCate == nameCate).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        children: [
          SizedBox(
              height: 50,
              child: Row(children: [
                SizedBox(
                  width: 100,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          _foundProduct = _list;
                          _onSelected(-1);
                          _isSeclected = true;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        padding: EdgeInsets.all(10),
                        height: 40,
                        decoration: BoxDecoration(
                            color: _isSeclected
                                ? Colors.teal.shade700
                                : Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Text(
                          'Tất cả',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _isSeclected ? Colors.white : Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listCate.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              _onSelected(index);
                              _isSeclected = false;
                              _FilterPro(listCate[index].nameCate.toString());
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10, left: 10),
                              padding: EdgeInsets.all(10),
                              height: 30,
                              decoration: BoxDecoration(
                                  color: _selectedIndex != null &&
                                          _selectedIndex == index
                                      ? Colors.teal.shade700
                                      : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Text(
                                '${listCate[index].nameCate}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: _selectedIndex != null &&
                                          _selectedIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ));
                      }),
                )
              ])),
          Expanded(
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: RefreshWidget(
                      onRefresh: loadList,
                      key: key,
                      keyRefresh: keyRefresh,
                      child: StaggeredGridView.countBuilder(
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 5.0,
                        itemCount: _foundProduct.length,
                        crossAxisCount: 4,
                        itemBuilder: (BuildContext context, int index) =>
                            ItemGridViewProduct(
                          detailProduct: _foundProduct[index],
                        ),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(2),
                      ))))
        ],
      ),
    );
  }
}
