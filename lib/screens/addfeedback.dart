import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/firebase/detailorder.dart';
import 'package:plants_app/firebase/feedback.dart';
import 'package:plants_app/firebase/product.dart';
import 'package:plants_app/model/mddetailproduct.dart';
import 'package:plants_app/model/mdfeedback.dart';
import 'package:plants_app/screens/listorder.dart';

class AddFeedback extends StatefulWidget {
  String? id;
  String? idOrder;
  AddFeedback(this.idOrder, this.id);

  @override
  _AddFeedbackState createState() => _AddFeedbackState();
}

class _AddFeedbackState extends State<AddFeedback> {
  String UID = "";
  final feedbackController = new TextEditingController();
  String noidung = '';
  MDFeedback mdFeedback = new MDFeedback();
  FetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    UID = user!.uid;
  }

  DetailProduct listProductFeed = new DetailProduct(
      imgProduct:
          'https://firebasestorage.googleapis.com/v0/b/appplants-fbbf8.appspot.com/o/images%2Ftrauba1-removebg-preview.png?alt=media&token=ebf7d3d1-8483-48be-9437-83cf489e3894',
      namePro: '',
      pricePro: '1');
  FetchProduct() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic resultPro = await DataProduct().getProductIdList(widget.id);

    if (resultPro == null) {
      print('unable');
    } else {
      if (this.mounted) {
        setState(() {
          listProductFeed = resultPro;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    FetchProduct();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[Colors.teal.shade900, Colors.teal.shade600])),
        ),
        title: Text('Viết Đánh Giá'),
      ),
      body: Container(
          color: Colors.grey.shade300,
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image: NetworkImage(listProductFeed.imgProduct),
                        height: 100,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${listProductFeed.namePro}',
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            '${listProductFeed.idCate}',
                            style: TextStyle(color: Colors.teal.shade500),
                          ),
                          Text(
                              '${NumberFormat('###,###').format(int.parse(listProductFeed.pricePro.toString()))}',
                              style: TextStyle(color: Colors.red, fontSize: 17))
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.teal.shade900,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  maxLines: 10,
                  style: TextStyle(fontSize: 18),
                  keyboardType: TextInputType.name,
                  controller: feedbackController,
                  onChanged: (value) {
                    setState(() {
                      noidung = value;
                    });
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText:
                          'Hãy chia sẻ những điều bạn thích về sản phẩm này nhé !! ',
                      labelStyle: TextStyle(color: Colors.teal.shade900),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(now);
                      mdFeedback.idSanPham = listProductFeed.id;
                      mdFeedback.ngay = formattedDate;
                      if (noidung.isNotEmpty) {
                        mdFeedback.noiDung = noidung;
                        Navigator.of(context).pop(MaterialPageRoute(
                            builder: (context) => ListOrder()));
                        FirFeedback().addListFeedback(mdFeedback);
                        FirListDetailOrder().updateStateDetailOrder(
                            widget.idOrder.toString(), widget.id.toString());

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Cảm ơn bạn đã đánh giá sản phẩm của chúng tôi')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Vui lòng nhập nội dung đánh giá của bạn')));
                      }
                    });
                  },
                  minWidth: 200,
                  height: 50,
                  color: Colors.teal.shade800,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    'Đánh Giá',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
