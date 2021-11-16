import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/firebase/product.dart';
import 'package:plants_app/handle/favorite.dart';
import 'package:plants_app/handle/favoritelistproduct.dart';
import 'package:plants_app/model/mdcategory.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/model/mdfavorites.dart';
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
 
//  List<Category> listCategory = [];
//    FetchCate()async{
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp();
//     dynamic result= await DataProduct().showCategory(widget.detailProduct.idCate);
//     if(result==null){
//       print('unable');
//     }else{
//       setState(() {
//         listCategory=result;
//       });
//     }
//   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //FetchCate();
  }
  @override
  Widget build(BuildContext context) {
    int isimportant=0;
     Favorites favorites = new Favorites(
        id: widget.detailProduct.id,
        isImportant:0 ,
        idProduct: widget.detailProduct.id,
        productName: widget.detailProduct.namePro,
        categoryName: widget.detailProduct.idCate,
        price: widget.detailProduct.pricePro,
        images: widget.detailProduct.imgProduct);
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailsProduct(detailProduct: widget.detailProduct)));
        },
        child: Container(
            width: 130,
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
                  width: 130,
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
                            placeholder: NetworkImage('${widget.detailProduct.imgProduct}'),
                            image: NetworkImage(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${NumberFormat('###,###').format(int.parse(widget.detailProduct.pricePro.toString()))}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.red.shade800,
                          fontWeight: FontWeight.bold),
                    ),
                    FavIconListPro(favorites)
                  ],
                ))
              ],
            )));
  }
}
