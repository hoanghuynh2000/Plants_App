import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plants_app/model/mdpromotion.dart';

class ItemPromotion extends StatefulWidget {
  MDPromotion? promotion;
  ItemPromotion({this.promotion});

  @override
  _ItemPromotionState createState() => _ItemPromotionState();
}

class _ItemPromotionState extends State<ItemPromotion> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Thông Tin Ưu Đãi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                  Colors.teal.shade900,
                  Colors.teal.shade600
                ])),
          ),
        ),
        body: Container(
            height: size.height,
            color: Colors.grey.shade300,
            width: size.width,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              '${widget.promotion!.namePromo} | Giảm ${widget.promotion!.discount}% tối đa ${widget.promotion!.discountMax} VND ',
                              maxLines: 3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Hạn sử dụng: ${widget.promotion!.dateEnd}',
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.grey.shade500),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                            height: 30,
                            width: 130,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text('${widget.promotion!.id}'),
                            )),
                        MaterialButton(
                          height: 30,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: '${widget.promotion!.id}'));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Sao chép thành công !'),
                            ));
                          },
                          color: Colors.teal.shade800,
                          child: Text(
                            'Sao Chép',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Điều khoản sử dụng:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              children: [
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Voucher không áp dụng đồng thời với các chương trình khuyến mãi khác.')),
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Voucher áp dụng giảm giá ${widget.promotion!.discount}% trên tổng hóa đơn tối đa ${widget.promotion!.discountMax}VND.')),
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Voucher áp dụng cho nhiều lần thanh toán.')),
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Thời gian áp dụng voucher từ ngày ${widget.promotion!.dateStart} đến ngày ${widget.promotion!.dateEnd}. Voucher có thể kế thúc sớm tùy vào chính sách của cửa hàng.')),
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Voucher áp dụng thanh toán online hoặc thanh toán trực tiếp tại cửa hàng.')),
                                ListTile(
                                    minLeadingWidth: 5,
                                    leading: Icon(
                                      Icons.fiber_manual_record,
                                      size: 12,
                                      color: Colors.teal.shade800,
                                    ),
                                    title: Text(
                                        'Voucher không được hoàn lại và không có giá trị quy đổi thành tiền mặt.')),
                              ],
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )));
  }
}
