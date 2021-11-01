import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:plants_app/fake/productfake.dart';
import 'package:plants_app/handle/refresh.dart';
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
  List<DetailProduct> _list = FakeProduct.toList();
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
                    colors: <Color>[
                  Colors.teal.shade900,
                  Colors.teal.shade600
                ])),
          ),
          title: Text(
            widget.category.nameCate.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(5),
            child: StaggeredGridView.countBuilder(
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 5.0,
              itemCount: _list.length,
              crossAxisCount: 4,
              itemBuilder: (BuildContext context, int index) =>
                  ItemGridViewProduct(
                detailProduct: _list[index],
              ),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
            )));
  }
}
