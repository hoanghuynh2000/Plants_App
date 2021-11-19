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
  bool _passwordVisible = false;
  String? email;
  String? password;
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

    return WillPopScope(
        onWillPop: () async => true,
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
                          // padding: EdgeInsets.only(top: 100),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                        Text(
                          "Đăng Nhập",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.teal.shade800,
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                                  labelStyle: TextStyle(color: Colorbtn),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide:
                                        BorderSide(color: Colors.teal.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
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
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colorbtn,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  prefixIcon: Icon(Icons.lock, color: Colorbtn),
                                  labelStyle: TextStyle(color: Colorbtn),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide:
                                        BorderSide(color: Colors.teal.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                            )),
                        Row(
                          children: [
                            SizedBox(width: width * 0.55),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FogetPassword()));
                                },
                                child: Text(
                                  'Quên mật khẩu ?',
                                  style: TextStyle(
                                      color: Colorbtn,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        Container(
                          child: BlocListener<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is LoginSucessfulState) {
                                navigateToHomeScreen(context, state.user);
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
                          height: 40,
                          minWidth: width * 0.6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUpPageParent(
                                      userRepository: widget.userResponsitory,
                                    )));
                          },
                          child: Text('Đăng Kí',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Comfortaa',
                                  fontSize: 18)),
                          color: Colors.red.shade700,
                          height: 40,
                          minWidth: width * 0.6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        ),
                      ]))),
                ))
          ],
        ));
  }

  Widget buildInitialUi() {
    return Container(
      height: 20,
      padding: EdgeInsets.all(5.0),
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
