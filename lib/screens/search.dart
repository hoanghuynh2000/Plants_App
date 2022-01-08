import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/firebase/product.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/screens/detailsproduct.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<DetailProduct> listProAll = [];
  List<DetailProduct> listProFiller = [];
  FetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result = await DataProduct().getAllProductList();
    if (result == null) {
      print('unable');
    } else {
      setState(() {
        listProAll = result;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchData();
  }

  final searchController = new TextEditingController();

  String search = '';
  Icon icon = Icon(Icons.search);
  Widget cus = Text('Tìm kiếm');
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var listProFiller = listProAll
        .where(
            (pro) => pro.namePro!.toLowerCase().contains(search.toLowerCase()))
        .toList();

    if (listProFiller.isNotEmpty) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal.shade800,
            title: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Nhập tên sản phẩm',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 17)),
              textInputAction: TextInputAction.go,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          body: Container(
              height: height,
              width: width,
              color: Colors.grey.shade200,
              child: Column(children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: listProFiller.length,
                        itemBuilder: (context, index) {
                          final item = listProFiller[index];

                          return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsProduct(
                                        detailProduct: listProFiller[index])));
                              },
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.teal.shade400,
                                    backgroundImage:
                                        NetworkImage(item.imgProduct),
                                  ),
                                  title: Row(children: [
                                    Container(
                                      width: 190,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${item.namePro}',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Text(
                                            '${item.idCate}',
                                            style: TextStyle(
                                                color: Colors.teal.shade500),
                                          ),
                                          Text(
                                              '${NumberFormat('###,###').format(int.parse(item.pricePro.toString()))}',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17))
                                        ],
                                      ),
                                    ),
                                  ])));
                        }))
              ])));
    } else {
      listProFiller = listProAll;
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal.shade800,
            title: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Nhập tên sản phẩm',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 17)),
              textInputAction: TextInputAction.go,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          body: Container(
              height: height,
              width: width,
              color: Colors.grey.shade200,
              child: Column(children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: listProFiller.length,
                        itemBuilder: (context, index) {
                          final item = listProFiller[index];

                          return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsProduct(
                                        detailProduct: listProFiller[index])));
                              },
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.teal.shade400,
                                    backgroundImage:
                                        NetworkImage(item.imgProduct),
                                  ),
                                  title: Row(children: [
                                    Container(
                                      width: 190,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${item.namePro}',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Text(
                                            '${item.idCate}',
                                            style: TextStyle(
                                                color: Colors.teal.shade500),
                                          ),
                                          Text(
                                              '${NumberFormat('###,###').format(int.parse(item.pricePro.toString()))}',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17))
                                        ],
                                      ),
                                    ),
                                  ])));
                        }))
              ])));
    }
  }
}
