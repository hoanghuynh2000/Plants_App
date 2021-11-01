import 'package:flutter/material.dart';

class ForgetPassword2 extends StatefulWidget {
  ForgetPassword2({Key? key}) : super(key: key);

  @override
  _ForgetPassword2State createState() => _ForgetPassword2State();
}

class _ForgetPassword2State extends State<ForgetPassword2> {
  @override
  Widget build(BuildContext context) {
    String sdt = '0123456789';
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color Colorbtn = Colors.teal.shade900;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/backgroundreset.jpg"),
                    fit: BoxFit.cover)),
          ),
          Column(
            children: [
              SizedBox(
                height: height * 0.13,
              ),
              Container(
                padding: EdgeInsets.only(left: width * 0.1),
                child: SizedBox(
                  width: width * 0.5,
                  child: Text(
                    "Vui lòng nhập mã OTP đã gửi đến số điện thoại ${sdt} ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: width * 0.1),
                width: width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _textFieldOTP(first: true, last: false),
                    _textFieldOTP(first: false, last: false),
                    _textFieldOTP(first: false, last: false),
                    _textFieldOTP(first: false, last: true),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: width * 0.1),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text('Xác Nhận',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Comfortaa',
                          fontSize: 18)),
                  color: Colorbtn,
                  height: 40,
                  minWidth: width * 0.6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _textFieldOTP({required bool first, last}) {
    return Container(
      height: 60,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.teal.shade900),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
