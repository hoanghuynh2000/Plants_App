import 'package:flutter/material.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/screens/detailsproduct.dart';

class ItemProduct extends StatefulWidget {
  //ItemProduct({Key? key}) : super(key: key);
  DetailProduct detailProduct;
  ItemProduct({required this.detailProduct});
  @override
  _ItemProductState createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  AnimationController? iconHeart;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailsProduct(detailProduct: widget.detailProduct)));
        },
        child: Container(
            width: 140,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                      offset: Offset(0, 3),
                      color: Colors.grey.shade300,
                      blurRadius: 10)
                ],
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            //margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 140,
                  decoration: ShapeDecoration(
                      color: Colors.teal.shade50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  height: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Center(
                          heightFactor: 0.7,
                          child: FadeInImage(
                            placeholder: AssetImage('./assets/images/load.gif'),
                            image: AssetImage(
                                '${widget.detailProduct.imgProduct}'),
                            fit: BoxFit.fitHeight,
                          ))),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${widget.detailProduct.namePro}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.teal.shade800),
                ),
                Text('${widget.detailProduct.idCate}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style:
                        TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                Expanded(
                    child: Row(
                  children: [
                    Text(
                      '${widget.detailProduct.pricePro}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.red.shade800,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
              ],
            )));
  }
}
