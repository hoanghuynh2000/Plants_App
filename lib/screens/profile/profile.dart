import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/firebase/UserFirebase.dart';
import 'package:plants_app/handle/refresh.dart';
import 'package:plants_app/layoutdrawer.dart';
import 'package:plants_app/model/mdUser.dart';
import 'package:plants_app/respository/user_respon.dart';
import 'package:plants_app/screens/profile/changepassword.dart';

class Profile extends StatefulWidget {
  UserResponsitory? userResponsitory;
  User? user;
  MDUser? itemUser;
  Profile({this.user, this.userResponsitory, this.itemUser});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late DateTime _selectedDate;
  final format = DateFormat("dd/MM/yyyy");
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> key =
      new GlobalKey<RefreshIndicatorState>();
  List<int> dataload = [];
  PickedFile? _imageFile;
  File? file;
  bool check = false;
  final ImagePicker _picker = ImagePicker();
  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 4000));

    final random = Random();
    final data = List.generate(100, (_) => random.nextInt(100));
    if (this.mounted) {
      setState(() => this.dataload = data);
    }
  }

  final _formKey = GlobalKey<FormState>();

  String? name;
  String? gender;
  String? birthday;
  String? phoneNumber;
  String? email;
  String? address;
  String? image;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerBirthday = TextEditingController();
  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  final snackBar = SnackBar(content: Text('c???p nh???t th??ng tin th??nh c??ng!'));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerName.text = widget.itemUser!.name!;
    _controllerAddress.text = widget.itemUser!.address!;
    _controllerBirthday.text = widget.itemUser!.birthday!;
    _controllerEmail.text = widget.itemUser!.email!;
    _controllerPhoneNumber.text = widget.itemUser!.phoneNumber!;
    gender = widget.itemUser!.gender;
    image = widget.itemUser!.image;
    birthday = widget.itemUser!.birthday;
    _character = gender;
  }

  UpdateDate(
    String name,
    String gender,
    String birthday,
    String phoneNumber,
    String email,
    String address,
    String image,
  ) async {
    String? id = widget.user!.uid;
    if (file != null) {
      image = await uploadImage();
    }
    DataUser()
        .UpdateUser(id, name, gender, birthday, phoneNumber, address, image);
  }

  Future<String> uploadImage() async {
    String? id = widget.user!.uid;

    var taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(id + "_" + file!.path)
        .putFile(file!);

    return taskSnapshot.ref.getDownloadURL();
  }

  String? _character;

  @override
  Widget build(BuildContext context) {
    gender = _character;
    _controllerBirthday.text = birthday!;
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
              child: RefreshWidget(
                onRefresh: loadList,
                key: key,
                keyRefresh: keyRefresh,
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (text) {
                                  if (text != null) {
                                    if (text.isEmpty) {
                                      return "Vui l??ng nh???p h??? t??n";
                                    }
                                    return null;
                                  }
                                },
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
                                      borderSide: BorderSide(
                                          color: Colors.teal.shade700)),
                                  labelText: 'H??? T??n',
                                  labelStyle: new TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      child: Row(children: [
                                    Radio<String>(
                                      value: 'Nam',
                                      groupValue: _character,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _character = value!;
                                        });
                                      },
                                    ),
                                    Text('Nam'),
                                  ])),
                                  Container(
                                      child: Row(children: [
                                    Radio<String>(
                                      value: 'N???',
                                      groupValue: _character,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _character = value!;
                                        });
                                      },
                                    ),
                                    Text('N???'),
                                  ])),
                                  Container(
                                      child: Row(children: [
                                    Radio<String>(
                                      value: 'Kh??c',
                                      groupValue: _character,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _character = value!;
                                        });
                                      },
                                    ),
                                    Text('Kh??c'),
                                  ])),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                  decoration: InputDecoration(
                                    suffixIcon:
                                        Icon(Icons.calendar_today_rounded),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.teal.shade700)),
                                    labelText: 'Ng??y Sinh',
                                    labelStyle:
                                        new TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      birthday = newValue!;
                                    });
                                  },
                                  focusNode: AlwaysDisabledFocusNode(),
                                  controller: _controllerBirthday,
                                  onTap: () {
                                    // _selectDate(context);
                                    showDatePicker(
                                        context: context,
                                        locale: const Locale('vi'),
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900, 1),
                                        lastDate: DateTime.now(),
                                        helpText: 'Ng??y Sinh',
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
                                              dialogBackgroundColor:
                                                  Colors.white,
                                            ),
                                            child: picker!,
                                          );
                                        }).then((selectedDate) {
                                      //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd/MM/yyyy')
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
                              TextFormField(
                                validator: (text) {
                                  if (text!.isEmpty || text.length < 10) {
                                    return "Vui l??ng ki???m tra s??? ??i???n tho???i";
                                  }
                                  return null;
                                },
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
                                      borderSide: BorderSide(
                                          color: Colors.teal.shade700)),
                                  labelText: 'S??? ??i???n Tho???i',
                                  labelStyle: new TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (text) {
                                  email = text;
                                },
                                enabled: false,
                                controller: _controllerEmail,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.teal.shade700)),
                                  labelText: 'Email',
                                  labelStyle: new TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade700)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return "Vui l??ng nh???p ?????a ch???";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (text) {
                                  address = text;
                                },
                                controller: _controllerAddress,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.teal.shade700)),
                                  labelText: '?????a Ch???',
                                  labelStyle: new TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (check == true) ...[
                                Container(
                                  child: buildLoadingUi(),
                                ),
                              ],
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MaterialButton(
                                    minWidth: 150,
                                    height: 40,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    color: Colors.teal.shade800,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          SubmitUpdate();
                                          check = true;
                                        });
                                        Timer(Duration(milliseconds: 5000), () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LayoutDrawer(
                                                        userResponsitory: widget
                                                            .userResponsitory,
                                                      )));
                                        });
                                      }
                                    },
                                    child: Text(
                                      'C???p Nh???t',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  MaterialButton(
                                    minWidth: 150,
                                    height: 40,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    color: Colors.red.shade900,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangePassword()));
                                    },
                                    child: Text(
                                      '?????i M???t Kh???u',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            if (file == null) ...[
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
                                      placeholder: AssetImage(
                                          './assets/images/load.gif'),
                                      image: NetworkImage('$image'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ] else ...[
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
                                      placeholder: AssetImage(
                                          './assets/images/load.gif'),
                                      image: FileImage(file!),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                            Positioned(
                              bottom: 1.0,
                              right: 5.0,
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.teal.shade500),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: ((builder) => bottomSheet()),
                                      );
                                    },
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
            )));
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

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Ch???n h??nh ???nh t??? ",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            MaterialButton(
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  Text("M??y ???nh"),
                ],
              ),
              onPressed: () {
                takePhoto(ImageSource.camera);
                if (file != null) {
                  uploadImage();
                }
              },
            ),
            MaterialButton(
              child: Row(
                children: [Icon(Icons.image), Text("Th?? vi???n ???nh")],
              ),
              onPressed: () {
                takePhoto(ImageSource.gallery);
                if (file != null) {
                  uploadImage();
                }
              },
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    XFile? xfile = await ImagePicker().pickImage(source: source);
    if (xfile != null) {
      print("file " + xfile.path);
      file = File(xfile.path);
      setState(() {});
    }
  }

  void SubmitUpdate() {
    UpdateDate(
        _controllerName.text,
        gender!,
        birthday!,
        _controllerPhoneNumber.text,
        _controllerEmail.text,
        _controllerAddress.text,
        image!);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
