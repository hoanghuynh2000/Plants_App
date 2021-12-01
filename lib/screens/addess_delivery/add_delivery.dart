import 'package:address_picker/address_picker.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/firebase/address.dart';
import 'package:plants_app/screens/addess_delivery/infor_delivery.dart';

// @dart=2.9
class AddDelivery extends StatefulWidget {
  AddDelivery({Key? key}) : super(key: key);

  @override
  _AddDeliveryState createState() => _AddDeliveryState();
}

class _AddDeliveryState extends State<AddDelivery> {
  TextEditingController _controllerName = TextEditingController();

  TextEditingController _controllerPhoneNumber = TextEditingController();

  TextEditingController _controllerAddress = TextEditingController();
  String? name;
  bool check = true;
  String? phoneNumber;
  String? address;
  String? street;
  BorderRadius boderTextFild = BorderRadius.all(Radius.circular(15));
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Thêm địa chỉ giao hàng'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Colors.teal.shade900,
              Colors.teal.shade600
            ])),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (text) {
                              if (text != null) {
                                if (text.isEmpty) {
                                  return "Vui lòng nhập họ tên";
                                }
                                return null;
                              }
                            },
                            //textDirection: TextDirection.LTR,
                            onChanged: (text) {
                              // setState(() {
                              //_controllerName.text = text;
                              name = text;
                              // });
                            },
                            controller: _controllerName,

                            decoration: InputDecoration(
                              // filled: true,
                              // fillColor: Colors.white,
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal.shade300),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  // borderRadius: boderTextFild,
                                  borderSide:
                                      BorderSide(color: Colors.teal.shade700)),
                              labelText: 'Họ Tên',
                              labelStyle:
                                  new TextStyle(color: Colors.grey.shade700),
                              enabledBorder: UnderlineInputBorder(
                                  // borderRadius: boderTextFild,
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (text) {
                              if (text!.isEmpty || text.length < 10) {
                                return "Vui lòng kiểm tra số điện thoại";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            //textDirection: TextDirection.LTR,
                            onChanged: (text) {
                              // setState(() {
                              //_controllerName.text = text;
                              phoneNumber = text;
                              // });
                            },
                            controller: _controllerPhoneNumber,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                //  borderRadius: boderTextFild,
                                borderSide:
                                    BorderSide(color: Colors.teal.shade300),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  // borderRadius: boderTextFild,
                                  borderSide:
                                      BorderSide(color: Colors.teal.shade700)),
                              labelText: 'Số Điện Thoại',
                              // filled: true,
                              // fillColor: Colors.white,
                              labelStyle:
                                  new TextStyle(color: Colors.grey.shade700),
                              enabledBorder: UnderlineInputBorder(
                                  // borderRadius: boderTextFild,
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Vui lòng nhập địa chỉ";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (text) {
                              street = text;
                            },
                            controller: _controllerAddress,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                //  borderRadius: boderTextFild,
                                borderSide:
                                    BorderSide(color: Colors.teal.shade300),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  // borderRadius: boderTextFild,
                                  borderSide:
                                      BorderSide(color: Colors.teal.shade700)),
                              labelText: 'Số nhà/đường',
                              // filled: true,
                              // fillColor: Colors.white,
                              labelStyle:
                                  new TextStyle(color: Colors.grey.shade700),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: AddressPicker(
                              onAddressChanged: (text) {
                                address = text;
                              },
                              buildItem: (text) {
                                return Container(
                                    child: Text(text,
                                        style: TextStyle(color: Colors.black)));
                              },
                            ),
                          ),
                          if (check == false) ...[
                            Container(
                              child: Text(
                                'Vui lòng chọn địa chỉ',
                                style: TextStyle(color: Colors.red.shade600),
                              ),
                            )
                          ],
                          SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            minWidth: 250,
                            height: 40,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            color: Colors.teal.shade800,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print(address);
                                if (address!.contains('Xã') == true ||
                                    address!.contains('Phường') == true) {
                                  print(check);
                                  setState(() {
                                    check = true;
                                  });
                                  AddressFirebase().AddAddress(
                                      name!, phoneNumber!, street!, address!);
                                  final snackBar = SnackBar(
                                      content:
                                          Text('Thêm địa chỉ thành công!'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.of(context).pop();
                                  // Navigator.of(context).pushReplacement(
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             InforDelivery()));
                                } else {
                                  print(check);

                                  setState(() {
                                    check = false;
                                  });
                                }
                              }
                            },
                            child: Text(
                              'Thêm địa chỉ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ])))));
  }
}
