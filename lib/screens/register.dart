import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/bloc/regBloc/reg_bloc.dart';
import 'package:plants_app/bloc/regBloc/reg_event.dart';
import 'package:plants_app/bloc/regBloc/reg_state.dart';
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
                              BlocListener<UserRegBloc, UserRegState>(
                                listener: (context, state) {
                                  if (state is UserRegSuccessful) {
                                    navigateToLoginPage(context, state.user);
                                  }
                                },
                                child: BlocBuilder<UserRegBloc, UserRegState>(
                                  builder: (context, state) {
                                    if (state is UserRegInitial) {
                                      return buildInitialUi();
                                    } else if (state is UserLoadingState) {
                                      return buildLoadingUi();
                                    } else if (state is UserRegFailure) {
                                      return buildFailureUi(state.massage!);
                                    } else if (state is UserRegSuccessful) {
                                      // emailController.text = "";
                                      // passwordController.text = "";
                                      return Container();
                                    }
                                    return Container();
                                  },
                                ),
                              ),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Colors.teal.shade300),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    fillColor: Colors.white),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Colors.teal.shade300),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    fillColor: Colors.white),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Colors.teal.shade300),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    fillColor: Colors.white),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Colors.teal.shade300),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    fillColor: Colors.white),
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
                                onPressed: () {
                                  userRegBloc!.add(SignUpButtonOnPressEvent(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phoneNumber: phoneController.text,
                                      name: nameController.text));
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
                                height: 40,
                              ),
                            ]))))));
  }

  Widget buildInitialUi() {
    return Text("Waiting For Authentication");
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
