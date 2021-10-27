import 'package:flutter/material.dart';
import 'package:plants_app/model/mdpromotion.dart';
import 'package:plants_app/screens/promotionscreen/detail_promotion.dart';

class Promotion extends StatefulWidget {
  Promotion({Key? key}) : super(key: key);

  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  List<MDPromotion> lsPromo = [
    MDPromotion(
        id: '1',
        namePromo: 'Khuyến Mãi mùa hè  ',
        discount: '10',
        discountMax: '100.000',
        dateStart: '10/10/2021',
        dateEnd: '20/10/2021'),
    MDPromotion(
        id: '1',
        namePromo: 'Khuyến Mãi',
        discount: '10',
        discountMax: '100.000',
        dateStart: '10/10/2021',
        dateEnd: '20/10/2021'),
    MDPromotion(
        id: '1',
        namePromo: 'HKhuyến Mãi',
        discount: '10',
        discountMax: '100.000',
        dateStart: '10/10/2021',
        dateEnd: '20/10/2021')
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: ListView.builder(
          itemCount: lsPromo.length,
          itemBuilder: (context, index) {
            return _itemPromo(index);
          }),
    );
  }

  Widget _itemPromo(int index) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ItemPromotion(promotion: lsPromo[index])));
        },
        child: Container(
            // padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(top: 10, left: 16, right: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [

            //     Text(
            //       '${lsPromo[index].namePromo} | Giảm ${lsPromo[index].discount}% tối đa ${lsPromo[index].discountMax} VND ',
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //       ),
            //     ),
            //     SizedBox(
            //       height: 3,
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Text(
            //           '${lsPromo[index].dateStart} - ',
            //           maxLines: 1,
            //           overflow: TextOverflow.ellipsis,
            //           style: TextStyle(color: Colors.grey.shade600),
            //         ),
            //         Text(
            //           '${lsPromo[index].dateEnd}',
            //           maxLines: 1,
            //           overflow: TextOverflow.ellipsis,
            //           style: TextStyle(color: Colors.grey.shade600),
            //         ),
            //       ],
            //     )
            //   ],
            // )
            child: ListTile(
              minLeadingWidth: 5,
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${lsPromo[index].dateStart} - ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Text(
                    '${lsPromo[index].dateEnd}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              leading: Icon(Icons.card_giftcard_outlined,
                  color: Colors.teal.shade800),
              title: Text(
                '${lsPromo[index].namePromo} | Giảm ${lsPromo[index].discount}% tối đa ${lsPromo[index].discountMax} VND ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )));
  }
}
