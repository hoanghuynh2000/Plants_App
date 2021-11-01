import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/Validation/validation_Email.dart';
import 'package:plants_app/screens/profile/changepassword.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late DateTime _selectedDate;
  final format = DateFormat("dd/MM/yyyy");
  String name = 'HoangDe';
  String gender = 'Nam';
  String birthday = '13/09/2000';
  String phoneNumber = '0364140311';
  String email = 'hoangde092000@gamil.com';
  String address = 'Tân Bình';
  String image = 'assets/images/cut5.jpg';
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerBirthday = TextEditingController();
  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controllerName.text = name;
    _controllerAddress.text = address;
    _controllerBirthday.text = birthday;
    _controllerEmail.text = email;
    _controllerPhoneNumber.text = phoneNumber;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Colors.teal.shade900,
              Colors.teal.shade600
            ])),
          ),
          backgroundColor: Colors.teal.shade900,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Colors.teal.shade900,
              Colors.teal.shade600
            ])),
            child: Stack(
              children: [
                Container(
                  height: size.height - 150,
                  margin: EdgeInsets.only(top: 70),
                  padding: EdgeInsets.only(top: 80, left: 30, right: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        //textDirection: TextDirection.LTR,
                        onChanged: (text) {
                          // setState(() {
                          //_controllerName.text = text;
                          name = text;
                          // });
                        },
                        controller: _controllerName,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal.shade700)),
                          labelText: 'Họ Tên',
                          labelStyle: new TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(
                          value: gender,
                          // icon: const Icon(Icons.arrow_downward),
                          // iconSize: 24,
                          // elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Colors.grey.shade400,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              gender = newValue!;
                            });
                          },
                          items: <String>['Nam', 'Nữ', 'Khác']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal.shade700)),
                            labelText: 'Ngày Sinh',
                            labelStyle: new TextStyle(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          focusNode: AlwaysDisabledFocusNode(),
                          controller: _controllerBirthday,
                          onTap: () {
                            // _selectDate(context);
                            showDatePicker(
                                context: context,
                                locale: const Locale('vi'),
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2019, 1),
                                lastDate: DateTime(2021, 12),
                                helpText: 'Ngày Sinh',
                                builder: (context, picker) {
                                  return Theme(
                                    //TODO: change colors
                                    data: ThemeData.dark().copyWith(
                                      colorScheme: ColorScheme.dark(
                                        primary: Colors.teal.shade400,
                                        onSecondary: Colors.white,
                                        // primaryVariant: Colors.white,
                                        onPrimary: Colors.white,
                                        surface: Colors.teal.shade400,
                                        onSurface: Colors.black,
                                      ),
                                      dialogBackgroundColor: Colors.white,
                                    ),
                                    child: picker!,
                                  );
                                }).then((selectedDate) {
                              //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('dd/MM/yyyy')
                                  .format(selectedDate!);
                              //TODO: handle selected date
                              if (selectedDate != null) {
                                setState(() {
                                  birthday = formattedDate.toString();
                                });
                              }
                            });
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
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
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal.shade700)),
                          labelText: 'Số Điện Thoại',
                          labelStyle: new TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        // validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",,
                        //textDirection: TextDirection.LTR,
                        onChanged: (text) {
                          // setState(() {
                          //_controllerName.text = text;
                          email = text;
                          // });
                        },
                        controller: _controllerEmail,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal.shade700)),
                          labelText: 'Email',
                          labelStyle: new TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        // validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",,
                        //textDirection: TextDirection.LTR,
                        onChanged: (text) {
                          // setState(() {
                          //_controllerName.text = text;
                          address = text;
                          // });
                        },
                        controller: _controllerAddress,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal.shade700)),
                          labelText: 'Địa Chỉ',
                          labelStyle: new TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      // DateTimeField(
                      //   //controller: _controllerBirthday,
                      //   format: format,
                      //   onShowPicker: (context, currentValue) {
                      //     return showDatePicker(
                      //         context: context,
                      //         firstDate: DateTime(1900),
                      //         initialDate: currentValue ?? DateTime.now(),
                      //         lastDate: DateTime(2100));
                      //   },
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            minWidth: 150,
                            height: 40,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            color: Colors.teal.shade800,
                            onPressed: () {
                              print(name);
                            },
                            child: Text(
                              'Cập Nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          MaterialButton(
                            minWidth: 150,
                            height: 40,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            color: Colors.red.shade900,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChangePassword()));
                            },
                            child: Text(
                              'Đổi Mật Khẩu',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                            width: 135,
                            height: 135,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Colors.teal.shade900,
                                    Colors.teal.shade500,
                                    Colors.teal.shade50
                                  ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                            ),
                            padding: EdgeInsets.all(3),
                            child: ClipRRect(
                              // width: 130,
                              // height: 130,
                              borderRadius: BorderRadius.circular(100.0),
                              child: FadeInImage(
                                placeholder:
                                    AssetImage('./assets/images/load.gif'),
                                image: AssetImage('${image}'),
                                fit: BoxFit.cover,
                              ),
                            )),
                        Positioned(
                          bottom: 1.0,
                          right: 5.0,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.teal.shade500),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 20,
                                )),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _controllerBirthday
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _controllerBirthday.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
