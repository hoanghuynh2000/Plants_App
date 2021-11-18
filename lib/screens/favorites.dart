import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/handle/refresh.dart';
import 'package:plants_app/model/mdfavorites.dart';
import 'package:plants_app/sqlite/favorites.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<FavoritesScreen> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> key =
      new GlobalKey<RefreshIndicatorState>();
  List<int> dataload = [];
  final data = FavoritesDatabase.instance;
  String id = "";
  int isImportant = 1;
  String idProduct = "";
  String productName = "";
  String categoryName = "";
  dynamic price = '';
  String images = "";
  late Favorites favorites;
  // ignore: deprecated_member_use
  List<Favorites> listFav = [];
  void isFav() async {
    listFav = await data.readfavorites();
    print(listFav);
  }

  @override
  void initState() {
    loadList();
    super.initState();
  }

  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 4000));

    final random = Random();
    final data = List.generate(100, (_) => random.nextInt(100));
    if (this.mounted) {
      setState(() => this.dataload = data);
    }
  }

  @override
  Widget build(BuildContext context) {
    isFav();

    return Scaffold(
        appBar: AppBar(
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
          title: Text('Danh Sách Yêu Thích'),
          backgroundColor: Colors.teal[900],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: RefreshWidget(
          onRefresh: loadList,
          key: key,
          keyRefresh: keyRefresh,
          child: ListView.builder(
            itemCount: listFav.length,
            itemBuilder: (context, index) {
              id = listFav[index].id.toString();
              isImportant = listFav[index].isImportant!;
              idProduct = listFav[index].idProduct.toString();
              productName = listFav[index].productName.toString();
              categoryName = listFav[index].categoryName.toString();
              price = listFav[index].price!;
              images = listFav[index].images!;
              favorites = new Favorites(
                  id: id,
                  isImportant: isImportant,
                  idProduct: idProduct,
                  productName: productName,
                  categoryName: categoryName,
                  price: price,
                  images: images);
              print(id);
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.all(
                  10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              image: NetworkImage('${images}'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${productName}',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        Text('${categoryName}'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${NumberFormat('###,###').format(int.parse(price.toString()))}',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                    Container(
                        width: 50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (this.mounted) {
                                      setState(() {
                                        data.deleteFav(id);
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite_sharp,
                                    color: Colors.red,
                                    size: 40,
                                  ))
                            ]))
                  ],
                ),
              );
            },
          ),
        )));
  }
}
