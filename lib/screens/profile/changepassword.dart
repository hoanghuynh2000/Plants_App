import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/respository/user_respon.dart';

class ChangePassword extends StatefulWidget {
  UserResponsitory userResponsitory;
  ChangePassword({required this.userResponsitory});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _passwordVisible2 = true;
  bool _passwordVisible1 = true;
  bool _passwordVisible3 = true;
  TextEditingController _passOld = TextEditingController();
  TextEditingController _passNew = TextEditingController();
  TextEditingController _passConfirm = TextEditingController();
  String? UID;

  String? passUser;
  var _formKey = GlobalKey<FormState>();
  final snackBar = SnackBar(content: Text('Đổi mật khẩu thành công!'));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.

  bool checkCurrentPasswordValid = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchUserInfo();
  }

  FetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    UID = user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Colors.teal.shade900,
              Colors.teal.shade600
            ])),
          ),
          title: Text('Đổi mật khẩu'),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (text) {
                    if (text != null) {
                      if (!(text.length > 5) || text.isEmpty) {
                        return "Vui lòng nhập mật khẩu lớn hơn 6 ký tự";
                      }
                      return null;
                    }
                  },
                  controller: _passOld,
                  obscureText: _passwordVisible1,
                  onChanged: (Text) {},
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal.shade700)),
                    labelText: 'Mật khẩu hiện tại',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible1
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.teal.shade700,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible1 = !_passwordVisible1;
                        });
                      },
                    ),
                    labelStyle: new TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (text) {
                    if (text != null) {
                      if (!(text.length > 5) || text.isEmpty) {
                        return "Vui lòng nhập mật khẩu lớn hơn 6 ký tự";
                      }
                      return null;
                    }
                  },
                  controller: _passNew,
                  obscureText: _passwordVisible2,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal.shade700)),
                    labelText: 'Mật khẩu mới',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible2
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.teal.shade700,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible2 = !_passwordVisible2;
                        });
                      },
                    ),
                    labelStyle: new TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (text) {
                    if (text != null) {
                      if (!(text.length > 5) || text.isEmpty) {
                        return "Vui lòng nhập mật khẩu lớn hơn 6 ký tự";
                      }
                      if (_passNew.text != text) {
                        return "Please validate your entered password";
                      }
                      return null;
                    }
                  },
                  controller: _passConfirm,
                  obscureText: _passwordVisible3,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal.shade700)),
                    labelText: 'Nhập lại mật khẩu',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible3
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.teal.shade700,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible3 = !_passwordVisible3;
                        });
                      },
                    ),
                    labelStyle: new TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.teal.shade800,
                  minWidth: 200,
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  onPressed: () async {
                    checkCurrentPasswordValid = await widget.userResponsitory
                        .validatePassword(_passOld.text);

                    setState(() {});

                    if (_formKey.currentState!.validate() &&
                        checkCurrentPasswordValid) {
                      widget.userResponsitory.updatePassword(_passConfirm.text);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Thay đổi mật khẩu',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )));
  }
}
