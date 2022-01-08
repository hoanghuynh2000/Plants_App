import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/firebase/oder.dart';
import 'package:plants_app/model/mdorder.dart';
import 'package:plants_app/payment/paypalservice.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../layoutdrawer.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  String? price;
  String? nameCus;
  String? phoneCus;
  String? addressCus;
  String? idOrder;
  PaypalPayment(
      {required this.onFinish,
      this.addressCus,
      this.nameCus,
      this.phoneCus,
      this.idOrder,
      this.price});

  @override
  _PaypalPaymentState createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var checkoutUrl;
  var executeUrl;
  var accessToken;
  List<mdOrder> order = [];
  // FetchDataShoppingCart() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  //   dynamic result = await FirListOder().getListOrderid(widget.id.toString());
  //   print(widget.id);
  //   if (result == null) {
  //     print('unable');
  //   } else {
  //     if (this.mounted) {
  //       setState(() {
  //         order = result;
  //       });
  //     }
  //   }
  // }

  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();
    // FetchDataShoppingCart();
    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
        // final snackBar =SnackBar(
        //     content: const Text('snack'),
        //     duration: const Duration(seconds: 1),
        //     action: SnackBarAction(
        //       label: 'ACTION',
        //       onPressed: () { },
        //     ),
        //   );
        // // ignore: deprecated_member_use
        // _scaffoldKey.currentState!.showSnackBar(snackBar);
      }
    });
  }

  String itemName = 'iPhone X';
  String itemPrice = '1.9';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": 'Thanh toán cho đơn hàng : ' + widget.idOrder!,
        "quantity": quantity,
        "price": widget.price,
        "currency": defaultCurrency["currency"]
      }
    ];
    String totalAmount = widget.price!;
    String subTotalAmount = widget.price!;
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = widget.nameCus!;
    String userLastName = '';
    String addressCity = widget.addressCus!;
    String addressStreet = widget.addressCus!;
    String addressZipCode = '110014';
    String addressCountry = 'VietNam';
    String addressState = '';
    String addressPhoneNumber = widget.phoneCus!;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": widget.price,
            "currency": "USD",
            "details": {
              "subtotal": widget.price,
              "shipping": '0',
              "shipping_discount": 0
            }
          },
          "description": "The payment transaction description.",
          // "payment_options": {
          //   "allowed_payment_method":
          //       "INSTANT_FUNDING_SOURCE"
          // },
          "item_list": {
            "items": [
              {
                "name": "Thanh toán đơn hàng: " + widget.idOrder!,
                "quantity": 1,
                "price": widget.price,
                "currency": "USD"
              }
            ],

            // shipping address is not required though
            "shipping_address": {
              "recipient_name": widget.nameCus,
              "line1": '1',
              "line2": "",
              "city": widget.addressCus,
              "country_code": "VN",
              "postal_code": "73301",
              "phone": widget.phoneCus,
              "state": ""
            },
          }
        }
        //   "amount": {
        //     "total": totalAmount,
        //     "currency": defaultCurrency["currency"],
        //     "details": {
        //       "subtotal": subTotalAmount,
        //       "shipping": shippingCost,
        //       "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
        //     }
        //   },
        //   "description": "The payment transaction description.",
        //   "payment_options": {
        //     "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
        //   },
        //   "item_list": {
        //     "items": items,
        //     if (isEnableShipping && isEnableAddress)
        //       "shipping_address": {
        //         "recipient_name": userFirstName + " ",
        //         "line1": addressStreet,
        //         "line2": "",
        //         "city": addressCity,
        //         "country_code": addressCountry,
        //         "postal_code": addressZipCode,
        //         "phone": addressPhoneNumber,
        //         "state": addressState
        //       },
        //   }
        // }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    if (checkoutUrl != null) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đặt hàng thành công')));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LayoutDrawer()),
                      (route) => false);
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đặt hàng thành công')));
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LayoutDrawer()),
                    (route) => false);
              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Đặt hàng thành công')));
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LayoutDrawer()),
                  (route) => false);
            }
            if (request.url.contains(cancelURL)) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Đặt hàng thành công')));
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LayoutDrawer()),
                  (route) => false);
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
