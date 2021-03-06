import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/handle/favoritelistproduct.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/model/mdfavorites.dart';
import 'package:plants_app/screens/detailproduct/itemproduct.dart';
import 'package:plants_app/screens/detailsproduct.dart';

class ItemGridViewProduct extends StatefulWidget {
  DetailProduct detailProduct;
  ItemGridViewProduct({required this.detailProduct});
  @override
  _ItemGridViewProductState createState() => _ItemGridViewProductState();
}

class _ItemGridViewProductState extends State<ItemGridViewProduct> {
  @override
  Widget build(BuildContext context) {
    int isimportant = 0;
    Favorites favorites = new Favorites(
        id: widget.detailProduct.id,
        isImportant: 0,
        idProduct: widget.detailProduct.id,
        productName: widget.detailProduct.namePro,
        categoryName: widget.detailProduct.idCate,
        price: widget.detailProduct.pricePro,
        images: widget.detailProduct.imgProduct);

    return Container(
      decoration: BoxDecoration(),
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailsProduct(detailProduct: widget.detailProduct)));
        },
        child: Container(
            child: Column(children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                        offset: Offset(1, 1))
                  ]),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 150,
                  decoration: ShapeDecoration(
                      color: Colors.teal.shade50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Center(
                          heightFactor: 0.7,
                          child: FadeInImage(
                            placeholder: AssetImage('./assets/images/load.gif'),
                            image: NetworkImage(
                                '${widget.detailProduct.imgProduct}'),
                            fit: BoxFit.fitHeight,
                          ))),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.detailProduct.namePro}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16, color: Colors.teal.shade800),
                      ),
                      Text('${widget.detailProduct.idCate}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${NumberFormat('###,###').format(int.parse(widget.detailProduct.pricePro.toString()))}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.red.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          FavIconListPro(favorites)
                        ],
                      )
                    ],
                  ),
                )
              ])),
        ])),
      ),
    );
  }
}
