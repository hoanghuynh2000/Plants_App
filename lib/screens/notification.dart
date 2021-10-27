import 'package:flutter/material.dart';
import 'package:plants_app/model/mdnotification.dart';

class Noti extends StatefulWidget {
  Noti({Key? key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Noti> {
  List<MDNotification> lsNoti = [
    MDNotification(
        id: '1',
        infoNoti: 'Bạn đã đặt hàng thành công ',
        dateNoti: '20/10/2021',
        idCus: '1'),
    MDNotification(
        id: '1',
        infoNoti: 'Bạn đã đặt hàng thành công ',
        dateNoti: '20/10/2021',
        idCus: '1'),
    MDNotification(
        id: '1',
        infoNoti: 'Bạn đã đặt hàng thành công ',
        dateNoti: '20/10/2021',
        idCus: '1'),
    MDNotification(
        id: '1',
        infoNoti:
            'Bạn đã đặt hàng thành công 11111111111111111111111111111111111111111111111111111111111111111 ',
        dateNoti: '20/10/2021',
        idCus: '1'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: ListView.builder(
          itemCount: lsNoti.length,
          itemBuilder: (context, index) {
            return _itemNoti(index);
          }),
    );
  }

  Widget _itemNoti(int index) {
    // return InkWell(
    //     onTap: () {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) =>
    //                   ItemPromotion(promotion: lsPromo[index])));
    //     },
    //     child:
    return Container(
      // padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: ListTile(
        minLeadingWidth: 5,
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${lsNoti[index].dateNoti}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            )
          ],
        ),
        leading:
            Icon(Icons.notifications_outlined, color: Colors.teal.shade800),
        title: Text(
          '${lsNoti[index].infoNoti}',
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       '${lsNoti[index].infoNoti}',
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
      //           '${lsNoti[index].dateNoti}',
      //           maxLines: 1,
      //           overflow: TextOverflow.ellipsis,
      //           style: TextStyle(color: Colors.grey.shade600),
      //         ),
      //       ],
      //     )
      //   ],
    );
  }
}
