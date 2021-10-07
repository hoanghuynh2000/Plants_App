import 'package:flutter/material.dart';
import 'package:plants_app/fake/feedfake.dart';
import 'package:plants_app/model/mdfeedback.dart';
class Feedback extends StatelessWidget {
List<MDFeedback> mdFeedback=FakeFeedback.toList();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mdFeedback.length,
        itemBuilder: (context, index) {
          return Card( //                           <-- Card widget
            child: ItemFeedback(mdFeedback: mdFeedback[index])
          );
        },
      );
//      ListView(
//       children: <Widget>[
//           mdFeedback.map((e) => ItemFeedback(mdFeedback: e))
        
             
//       ],
// );
  }
}
class ItemFeedback extends StatelessWidget {                                
   MDFeedback mdFeedback=new MDFeedback();
  ItemFeedback({required this.mdFeedback});
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Row(
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child:  Image.asset('${"assets/images/cay1.png"}',),
          ),
          Column(
            children: [
              Text('${mdFeedback.tenKhachHang}'),
              Text('${mdFeedback.noiDung}')
            ],
          )
        ],
      ),
    );
  }
}