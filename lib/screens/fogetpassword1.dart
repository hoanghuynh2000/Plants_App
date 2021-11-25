import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/bloc/resetpassbloc/reset_bloc.dart';
import 'package:plants_app/bloc/resetpassbloc/reset_event.dart';
import 'package:plants_app/bloc/resetpassbloc/reset_state.dart';
import 'package:plants_app/main.dart';
import 'package:plants_app/respository/user_respon.dart';
import 'package:plants_app/screens/fogetpassword2.dart';
import 'package:plants_app/screens/login.dart';

class FogotPasswordParent extends StatelessWidget {
  UserResponsitory userResponsitory;
  FogotPasswordParent({required this.userResponsitory});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => ResetBloc(userResponsitory: userResponsitory),
      child: FogetPassword(userResponsitory: userResponsitory),
    );
  }
}

class FogetPassword extends StatefulWidget {
  UserResponsitory userResponsitory;
  FogetPassword({required this.userResponsitory});

  @override
  _FogetPasswordState createState() => _FogetPasswordState();
}

class _FogetPasswordState extends State<FogetPassword> {
  String? email;
  TextEditingController _emailController = TextEditingController();
  late ResetBloc resetBloc;
  final _formKey = GlobalKey<FormState>();

  bool checkCurrentPasswordValid = true;
  BorderRadius boderTextFild = BorderRadius.all(Radius.circular(10));
  @override
  Widget build(BuildContext context) {
    resetBloc = BlocProvider.of<ResetBloc>(context);
    Color Colorbtn = Colors.teal.shade900;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/backgroundreset.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.teal.shade900, //change your color here
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Quên mật khẩu",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade800,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: width * 0.85,
                                child: TextFormField(
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
                                  controller: _emailController,
                                  style: TextStyle(fontSize: 16),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (Text) {
                                    setState(() {
                                      email = Text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      prefixIcon: Icon(
                                        Icons.email_rounded,
                                        color: Colorbtn,
                                      ),
                                      hintText: 'Email',
                                      labelStyle: TextStyle(color: Colorbtn),
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
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: BlocListener<ResetBloc, ResetState>(
                                  listener: (context, state) {
                                    if (state is ResetSuccess) {
                                      showAlertDialog(email!);
                                    }
                                  },
                                  child: BlocBuilder<ResetBloc, ResetState>(
                                    builder: (context, state) {
                                      if (state is ResetInitial) {
                                        return buildInitialUi();
                                      } else if (state is ResetFailure) {
                                        return buildFailureUi(
                                            'Email chưa được đăng kí !');
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    resetBloc.add(
                                        ResetButtonOnPressEvent(email: email));
                                  }
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => ForgetPassword2()));
                                },
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
                            ])))
              ],
            )));
  }

  Future<String?> showAlertDialog(String email) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Quên mật khẩu'),
              content: Text('Vui lòng kiểm tra email ${email}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPageParent(
                                userRepository: widget.userResponsitory,
                              ))),
                  child: const Text('Đồng ý'),
                ),
              ],
            ));
  }

  Widget buildInitialUi() {
    return Container(
      height: 20,
      padding: EdgeInsets.all(5.0),
    );
  }

  Widget buildFailureUi(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "$message",
            style: TextStyle(color: Colors.red),
          ),
        ),
        buildInitialUi(),
      ],
    );
  }
}
