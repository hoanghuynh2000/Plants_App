import 'package:flutter/material.dart';
import 'package:plants_app/model/mddetailproduct.dart';

class ItemProduct extends StatefulWidget {
  //ItemProduct({Key? key}) : super(key: key);
  DetailProduct detailProduct = new DetailProduct();
  ItemProduct({required this.detailProduct});
  @override
  _ItemProductState createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  AnimationController? iconHeart;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(6),
      decoration: ShapeDecoration(
          shadows: [
            BoxShadow(
                offset: Offset(0, 3),
                color: Colors.grey.shade300,
                blurRadius: 10)
          ],
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
      //margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Container(
            width: 120,
            decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage('${widget.detailProduct.imgProduct}'),
                  fit: BoxFit.contain,
                  //height: 150,
                ),
                color: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            height: 120,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${widget.detailProduct.namePro}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: TextStyle(fontSize: 18, color: Colors.teal.shade800),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                '${widget.detailProduct.pricePro}',
                style: TextStyle(fontSize: 18, color: Colors.red.shade800),
              ),
            ],
          )
        ],
      ),
    );
  }
}
