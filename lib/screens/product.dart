import 'package:flutter/material.dart';
import 'package:plants_app/fake/productfake.dart';
import 'package:plants_app/model/mdcategory.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/screens/detailproduct/itemproduct.dart';
import 'package:plants_app/screens/itemgridviewproduct.dart';

class Product extends StatefulWidget {
  Product({Key? key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late Color colorCate = Colors.teal.shade700;
  List<Category> listCate = [
    Category(
        id: '1', nameCate: 'Cây Cảnh Mini', imgCate: 'assets/images/logo.png'),
    Category(
        id: '2', nameCate: 'Cây Cảnh Mini', imgCate: 'assets/images/logo.png'),
    Category(
        id: '3', nameCate: 'Cây Cảnh Mini', imgCate: 'assets/images/logo.png'),
    Category(
        id: '4', nameCate: 'Cây Cảnh Mini', imgCate: 'assets/images/logo.png'),
    Category(
        id: '5', nameCate: 'Cây Cảnh Mini', imgCate: 'assets/images/logo.png')
  ];
  List<DetailProduct> _list = FakeProduct.toList();

  List<DetailProduct> _foundProduct = [];
  @override
  void initState() {
    // TODO: implement initState
    _foundProduct = _list;
    super.initState();
  }

  void _FilterPro(String id) {
    setState(() {
      _foundProduct = _list.where((e) => e.id == id).toList();
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
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        padding: EdgeInsets.all(10),
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Text(
                          'Tất cả',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
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
                              _FilterPro(_list[index].idCate.toString());
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10, left: 10),
                              padding: EdgeInsets.all(10),
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Text(
                                '${listCate[1].nameCate}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ));
                      }),
                )
              ])),
          Expanded(
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: GridView(
                    children: _foundProduct
                        .map((e) => ItemGridViewProduct(detailProduct: e))
                        .toList(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 0.72,
                        // mainAxisSpacing: 1,
                        // crossAxisSpacing: 1,
                        maxCrossAxisExtent: 220),
                  )))
        ],
      ),
    );
  }
}