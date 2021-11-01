import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _passwordVisible = true;
  Color colorBtn = Colors.teal.shade900;
  String? name;
  String? phone;
  String? password;
  String? email;
  final nameController = new TextEditingController();
  final phoneController = new TextEditingController();
  final passwordController = new TextEditingController();
  final emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroundregister.jpg'),
              fit: BoxFit.fill),
        ),
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.teal.shade900, //change your color here
              ),
              backgroundColor: Color(0xF0F8FF),
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Center(
                    child: Container(
                        // margin: EdgeInsets.only(top: 50),
                        padding: EdgeInsets.all(20),

                        // width: width * 0.8,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextField(
                                controller: nameController,
                                onChanged: (String? value) {
                                  setState(() {
                                    name = value;
                                  });
                                },
                                style: TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.people,
                                      color: colorBtn,
                                    ),
                                    filled: true,
                                    hintText: 'Họ và tên',
                                    hintStyle: TextStyle(
                                        color: Colors.lightGreen.shade900,
                                        fontSize: 16),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    fillColor:
                                        Colors.grey.shade200.withOpacity(0.95)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                controller: phoneController,
                                onChanged: (String? value) {
                                  setState(() {
                                    phone = value;
                                  });
                                },
                                keyboardType: TextInputType.phone,
                                style: TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: colorBtn,
                                    ),
                                    filled: true,
                                    hintText: 'Số điện thoại',
                                    hintStyle: TextStyle(
                                        color: Colors.lightGreen.shade900,
                                        fontSize: 16),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    fillColor:
                                        Colors.grey.shade200.withOpacity(0.95)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                controller: emailController,
                                onChanged: (String? value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: colorBtn,
                                    ),
                                    filled: true,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        color: Colors.lightGreen.shade900,
                                        fontSize: 16),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    fillColor:
                                        Colors.grey.shade200.withOpacity(0.95)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                onChanged: (String? value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                                obscureText: _passwordVisible,
                                controller: passwordController,
                                style: TextStyle(fontSize: 16),
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
                                    hintStyle: TextStyle(
                                        color: colorBtn, fontSize: 16),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
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
                                height: 40,
                                minWidth: width * 0.6,
                                color: colorBtn,
                                onPressed: () {},
                                child: Text(
                                  'Đăng Kí',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Comfortaa'),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ]))))));
  }
}
