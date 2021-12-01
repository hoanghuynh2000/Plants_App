import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/bloc/regBloc/reg_bloc.dart';
import 'package:plants_app/bloc/regBloc/reg_event.dart';
import 'package:plants_app/bloc/regBloc/reg_state.dart';
import 'package:plants_app/colorsize/validation.dart';
import 'package:plants_app/layoutdrawer.dart';
import 'package:plants_app/respository/user_respon.dart';
import 'package:plants_app/screens/login.dart';

class SignUpPageParent extends StatelessWidget {
  UserResponsitory? userRepository;

  SignUpPageParent({this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserRegBloc(userResponsitory: userRepository),
      child: Register(userRepository: userRepository),
    );
  }
}

class Register extends StatefulWidget {
  UserResponsitory? userRepository;
  Register({this.userRepository});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

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
  String? authResult;
  UserRegBloc? userRegBloc;
  BorderRadius boderTextFild = BorderRadius.all(Radius.circular(10));
  bool check = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    userRegBloc = BlocProvider.of<UserRegBloc>(context);
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
            backgroundColor: Colors.grey.shade500.withOpacity(0.3),
            body: SingleChildScrollView(
                child: Center(
                    child: Container(
                        // margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 30, right: 30),

                        // width: width * 0.8,
                        child: Form(
                            key: _formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Đăng Kí',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.teal.shade800,
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
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
                                            color: Colors.teal.shade900,
                                            fontSize: 16),
                                        border: OutlineInputBorder(
                                          borderRadius: boderTextFild,
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade300),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: boderTextFild,
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade300),
                                        ),
                                        // errorText: Validation()
                                        //     .validateName(nameController.text),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius: boderTextFild),
                                        fillColor: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    validator: (text) {
                                      if (text!.isEmpty || text.length < 10) {
                                        return "Vui lòng kiểm tra số điện thoại";
                                      }
                                      return null;
                                    },
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
                                            color: Colors.teal.shade900,
                                            fontSize: 16),
                                        border: OutlineInputBorder(
                                          borderRadius: boderTextFild,
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade300),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: boderTextFild,
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade300),
                                        ),
                                        // errorText: Validation().validatePhone(
                                        //     phoneController.text),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius: boderTextFild),
                                        fillColor: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    validator: (text) {
                                      if (text != null) {
                                        if (text.length > 5 &&
                                            text.contains('@') &&
                                            text.endsWith('.com')) {
                                          return null;
                                        }
                                      }
                                      return 'Email không chính xác';
                                    },
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
                                            color: Colors.teal.shade900,
                                            fontSize: 16),
                                        border: OutlineInputBorder(
                                          borderRadius: boderTextFild,
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade300),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: boderTextFild,
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade300),
                                        ),
                                        // errorText: Validation().validateEmail(
                                        //     emailController.text),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius: boderTextFild),
                                        fillColor: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    validator: (text) {
                                      if ((text!.length < 6) || text.isEmpty) {
                                        return "Vui lòng nhập mật khẩu lớn hơn 6 ký tự";
                                      }
                                      return null;
                                    },
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
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                        filled: true,
                                        hintText: 'Mật khẩu',
                                        hintStyle: TextStyle(
                                            color: colorBtn, fontSize: 16),
                                        border: OutlineInputBorder(
                                          borderRadius: boderTextFild,
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade300),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: boderTextFild,
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade300),
                                        ),
                                        // errorBorder: OutlineInputBorder(
                                        //     borderSide:
                                        //         BorderSide(color: Colors.white),
                                        //     borderRadius: boderTextFild),
                                        // errorText: Validation()
                                        //     .validatePassword(
                                        //         passwordController.text),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius: boderTextFild),
                                        fillColor: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  BlocListener<UserRegBloc, UserRegState>(
                                    listener: (context, state) {
                                      if (state is UserRegSuccessful) {
                                        navigateToLoginPage(
                                            context, state.user);
                                      }
                                    },
                                    child:
                                        BlocBuilder<UserRegBloc, UserRegState>(
                                      builder: (context, state) {
                                        if (state is UserRegInitial) {
                                          return buildInitialUi();
                                        } else if (state is UserLoadingState) {
                                          return buildLoadingUi();
                                        } else if (state is UserRegFailure) {
                                          return buildFailureUi(
                                              'Tài khoản email đã tồn tại !');
                                        } else if (state is UserRegSuccessful) {
                                          // emailController.text = "";
                                          // passwordController.text = "";
                                          return Container();
                                        }
                                        return Container();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    height: 40,
                                    minWidth: width * 0.6,
                                    color: colorBtn,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        userRegBloc!.add(
                                            SignUpButtonOnPressEvent(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                phoneNumber:
                                                    phoneController.text,
                                                name: nameController.text));
                                      }
                                    },
                                    child: Text(
                                      'Đăng Kí',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Comfortaa'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPageParent(
                                                    userRepository:
                                                        widget.userRepository,
                                                  )));
                                    },
                                    child: Text('Đăng Nhập',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Comfortaa',
                                            fontSize: 18)),
                                    color: Colors.teal.shade700,
                                    height: 40,
                                    minWidth: width * 0.6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                  )
                                ])))))));
  }

  Widget buildInitialUi() {
    return Text("");
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailureUi(String message) {
    return Text(
      message,
      style: TextStyle(color: Colors.red),
    );
  }

  void navigateToLoginPage(BuildContext context, User user) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return LayoutDrawer(
          userResponsitory: widget.userRepository,
          user: user,
        );
      }));
    });
  }
}
