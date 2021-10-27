import 'package:flutter/material.dart';
import 'package:plants_app/fake/productfake.dart';
import 'package:plants_app/model/mdcategory.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/screens/itemgridviewproduct.dart';

class ListProduct extends StatefulWidget {
  Category category;
  ListProduct({required this.category});

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  List<DetailProduct> _list = FakeFeedback.toList();
  @override
  Widget build(BuildContext context) {
    _list =
        _list.where((element) => element.idCate == widget.category.id).toList();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.teal.shade900, Colors.teal.shade600])),
        ),
        title: Text(
          widget.category.nameCate.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
      ),
      body: Container(
        child: GridView(
          children:
              _list.map((e) => ItemGridViewProduct(detailProduct: e)).toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 0.78,
              // mainAxisSpacing: 1,
              // crossAxisSpacing: 1,
              maxCrossAxisExtent: 220),
        ),
      ),
    );
  }
}
