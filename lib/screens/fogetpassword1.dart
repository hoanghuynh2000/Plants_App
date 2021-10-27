import 'package:flutter/material.dart';
import 'package:plants_app/screens/fogetpassword2.dart';
class FogetPassword extends StatefulWidget {
  FogetPassword({Key? key}) : super(key: key);

  @override
  _FogetPasswordState createState() => _FogetPasswordState();
}

class _FogetPasswordState extends State<FogetPassword> {
  
  @override
  Widget build(BuildContext context) {
    Color Colorbtn=Colors.teal.shade900;
    double width= MediaQuery.of(context).size.width;
     double height= MediaQuery.of(context).size.height;
    return Scaffold(
      body:Stack(children: [
        Container(
        width: width,
          decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/backgroundreset.jpg"),
                        fit: BoxFit.cover)),),
                        Center(
                          child:Container(
                            padding: EdgeInsets.only(top: height*0.3),
                            child:Column(
                            
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              
                          width: width*0.7,
                          child: 
                            TextField(
                              style: TextStyle(fontSize: 20),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey[200]!.withOpacity(0.9),
                                  filled: true,
                                  prefixIcon: Icon(Icons.phone, color: Colorbtn,),
                                  hintText: 'Số điện thoại',
                                  labelStyle: TextStyle(color:Colorbtn),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: Colors.grey.shade200)),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.all(Radius.circular(20)))
                                    ),
                            )
                          ,
                        ),
                        SizedBox(height: 40,),
                       MaterialButton(onPressed: (){
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ForgetPassword2()));
                       },
                          child: Text('Quên mật khẩu',style: TextStyle(color: Colors.white,fontFamily:'Rokkitt',fontSize: 24)),
                          color:Colorbtn,
                          height: 50,
                          minWidth: width*0.6,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))
           ,),
                          ]
                        )
                       
                          )
                        ) 
      ],)
    );
  }
}