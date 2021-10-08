import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _passwordVisible = true;
  Color colorBtn = Colors.teal.shade900;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroundregister.jpg'),
              fit: BoxFit.cover),
        )),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: Container(
                    width: width * 0.8,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextField(
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.people,
                                  color: colorBtn,
                                ),
                                filled: true,
                                hintText: 'Họ và tên',
                                labelStyle: TextStyle(
                                    color: Colors.lightGreen.shade900,
                                    fontSize: 20),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                fillColor:
                                    Colors.grey.shade200.withOpacity(0.95)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            keyboardType: TextInputType.phone,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: colorBtn,
                                ),
                                filled: true,
                                hintText: 'Số điện thoại',
                                labelStyle: TextStyle(
                                    color: Colors.lightGreen.shade900,
                                    fontSize: 20),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                fillColor:
                                    Colors.grey.shade200.withOpacity(0.95)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: colorBtn,
                                ),
                                filled: true,
                                hintText: 'Email',
                                labelStyle: TextStyle(
                                    color: Colors.lightGreen.shade900,
                                    fontSize: 20),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                fillColor:
                                    Colors.grey.shade200.withOpacity(0.95)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            obscureText: _passwordVisible,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: colorBtn,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: colorBtn,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                filled: true,
                                hintText: 'Mật khẩu',
                                labelStyle:
                                    TextStyle(color: colorBtn, fontSize: 20),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                fillColor:
                                    Colors.grey.shade200.withOpacity(0.95)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            height: 50,
                            minWidth: width * 0.6,
                            color: colorBtn,
                            onPressed: () {},
                            child: Text(
                              'Đăng Kí',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'Rokkitt'),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ]))))
      ],
    );
  }
}
