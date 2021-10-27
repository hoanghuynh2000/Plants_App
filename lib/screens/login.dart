import 'package:flutter/material.dart';
import 'package:plants_app/screens/fogetpassword1.dart';
class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible=true;
  
  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;
    Color Colorbtn=Colors.teal.shade900;
    return Stack(
      children:[
        
        Container(
        width: width,
          decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/brDangNhap.jpg"),
                        fit: BoxFit.fitHeight)),),
        
        Scaffold(
      backgroundColor: Colors.transparent,
      body:Center(child: Container(
            padding: EdgeInsets.only(top: 40),
            
        child:
           Column(
          mainAxisAlignment: MainAxisAlignment.end,
          
          children: [
          
          Container(
            width: width*0.7,
           child: TextField(
             style: TextStyle(fontSize: 20),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              fillColor: Colors.grey[300]!.withOpacity(0.9),
              filled: true,
              prefixIcon: Icon(Icons.phone, color: Colorbtn,),
              hintText: 'Số điện thoại',
              labelStyle: TextStyle(color: Colorbtn),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.grey.shade200),
             ),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.all(Radius.circular(20)))
            ),
          )),
          SizedBox(height: 30,),
          Container(
            width: width*0.7,
           child:
           TextField(
             style: TextStyle(fontSize: 20),
             obscureText: _passwordVisible,
            decoration: InputDecoration(
              hintText: 'Mật khẩu',
              fillColor: Colors.grey[300]!.withOpacity(0.9),
              filled: true,
              suffixIcon:IconButton(
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
                   _passwordVisible = !_passwordVisible;
               });
             },),
              prefixIcon: Icon(Icons.lock,color: Colorbtn),
              labelStyle: TextStyle(color: Colorbtn),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.grey.shade200),
             ),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.all(Radius.circular(20)))
            ),
          )),
          Row(
            children: [
              SizedBox(width: width*0.55),
              TextButton(
                 onPressed: (){
                   Navigator.of(context).push( MaterialPageRoute(builder: (context)=>FogetPassword()));
                   
                 }, 
                 child: Text('Quên mật khẩu',style: TextStyle(color: Colorbtn,fontSize: 15,fontWeight: FontWeight.bold),))
            ],
          ),
           MaterialButton(onPressed: (){},
           child: Text('Đăng Nhập',style: TextStyle(color: Colors.white,fontFamily:'Rokkitt',fontSize: 24)),
           color: Colorbtn,
           height: 50,
           minWidth: width*0.6,
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))
           ,),
           SizedBox(height: 30,),
           Container(
             
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('Bạn chưa có tài khoản?',style: TextStyle(fontSize: 15),),
               TextButton(onPressed: (){}, child: Text('Đăng Kí',style:TextStyle(color: Colorbtn,fontSize: 22,fontFamily: 'Rokkitt',fontWeight:FontWeight.bold )))
             ],
           ),
           )
          
           
        ],)

       
         ))
        
       ,)
      ],
    
    )
    ;
  }
}