import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/bloc/loginBloc/login_bloc.dart';
import 'package:plants_app/bloc/loginBloc/login_event.dart';
import 'package:plants_app/bloc/loginBloc/login_state.dart';
import 'package:plants_app/bloc/regBloc/reg_bloc.dart';
import 'package:plants_app/layoutdrawer.dart';

import 'package:plants_app/respository/user_respon.dart';
import 'package:plants_app/screens/dashboard.dart';
import 'package:plants_app/screens/fogetpassword1.dart';
import 'package:plants_app/screens/register.dart';

class LoginPageParent extends StatelessWidget {
  UserResponsitory? userRepository;

  LoginPageParent({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userResponsitory: userRepository),
      child: LoginPage(userResponsitory: userRepository),
    );
  }
}

class LoginPage extends StatefulWidget {
  UserResponsitory? userResponsitory;

  LoginPage({this.userResponsitory});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = true;
  String? email = 'hoangde1@gmail.com';
  String? password = '123456';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  UserRegBloc? userRegBloc;
  late LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color Colorbtn = Colors.teal.shade900;
    loginBloc = BlocProvider.of<LoginBloc>(context);
    email = 'hoangde1@gmail.com';
    password = '123456';
    return WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            Container(
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/brDangNhap.jpg"),
                      fit: BoxFit.fitHeight)),
            ),
            Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Center(
                      child: Container(
                          padding: EdgeInsets.only(top: 100),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: BlocListener<LoginBloc, LoginState>(
                                    listener: (context, state) {
                                      if (state is LoginSucessfulState) {
                                        navigateToHomeScreen(
                                            context, state.user);
                                      }
                                    },
                                    child: BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                        if (state is LoginInitialState) {
                                          return buildInitialUi();
                                        } else if (state is LoginLoadingState) {
                                          return buildLoadingUi();
                                        } else if (state is LoginFailureState) {
                                          // emailController.text = "";
                                          // passwordController.text = "";
                                          return buildFailureUi(state.massage);
                                        }

                                        return Container();
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                    width: width * 0.8,
                                    child: TextField(
                                      onChanged: (value) {
                                        email = value;
                                      },
                                      controller: _emailController,
                                      style: TextStyle(fontSize: 16),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colorbtn,
                                          ),
                                          hintText: 'Email',
                                          labelStyle:
                                              TextStyle(color: Colorbtn),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                color: Colors.teal.shade300),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    )),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                    width: width * 0.8,
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                      controller: _passwordController,
                                      style: TextStyle(fontSize: 16),
                                      obscureText: _passwordVisible,
                                      decoration: InputDecoration(
                                          hintText: 'Mật khẩu',
                                          fillColor: Colors.white,
                                          filled: true,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colorbtn,
                                            ),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                          prefixIcon:
                                              Icon(Icons.lock, color: Colorbtn),
                                          labelStyle:
                                              TextStyle(color: Colorbtn),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                color: Colors.teal.shade300),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    )),
                                Row(
                                  children: [
                                    SizedBox(width: width * 0.55),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FogetPassword()));
                                        },
                                        child: Text(
                                          'Quên mật khẩu',
                                          style: TextStyle(
                                              color: Colorbtn,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    loginBloc.add(LoginButtonOnPressEvent(
                                        email: email, password: password));
                                  },
                                  child: Text('Đăng Nhập',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Comfortaa',
                                          fontSize: 18)),
                                  color: Colorbtn,
                                  height: 50,
                                  minWidth: width * 0.6,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Bạn chưa có tài khoản?',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUpPageParent(
                                                          userRepository: widget
                                                              .userResponsitory,
                                                        )));
                                          },
                                          child: Text('Đăng Kí',
                                              style: TextStyle(
                                                  color: Colorbtn,
                                                  fontSize: 20,
                                                  fontFamily: 'Rokkitt',
                                                  fontWeight: FontWeight.bold)))
                                    ],
                                  ),
                                )
                              ]))),
                ))
          ],
        ));
  }

  Widget buildInitialUi() {
    return Container(
      height: 50,
      padding: EdgeInsets.all(5.0),
      child: Text(
        "Đăng Nhập",
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.teal.shade800,
        ),
      ),
    );
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailureUi(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "Fail $message",
            style: TextStyle(color: Colors.red),
          ),
        ),
        buildInitialUi(),
      ],
    );
  }

  void navigateToHomeScreen(BuildContext context, User user) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return LayoutDrawer(
            user: user, userResponsitory: widget.userResponsitory);
      }));

      // Add Your Code here.
    });

    void navigateToSignUpScreen(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return SignUpPageParent(userRepository: widget.userResponsitory);
      }));
    }
  }
}
