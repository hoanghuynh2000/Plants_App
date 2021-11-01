import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final phoneController= new TextEditingController();
  final nameController=new TextEditingController();
  final contentController= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(title:Text('Thông tin liên hệ'),
      backgroundColor: Colors.teal.shade800 ,
      ),
      body:SingleChildScrollView(child:Column(
        children: [
   Container(

        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(image: ExactAssetImage('assets/images/logo.png'),fit:BoxFit.fitHeight,),
          color: Colors.white,
          ),
        
        margin: EdgeInsets.only(left: 15,right: 15,top:15),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color:Colors.white.withOpacity(0.85),),
          
          child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text('Plants Shop',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Comfortaa',
              color: Colors.teal.shade800)),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Số điện thoại',style: TextStyle(fontSize: 17),),
                  SizedBox(
                  height: 15,
            ),
                  Text('Email',style: TextStyle(fontSize: 17)),
                  SizedBox(
              height: 15,
            ),
                  Text('Địa Chỉ',style: TextStyle(fontSize: 17))
                ],
              ),
              Container(
                width: 200,
                child: 
                 Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('0123456789',
                  style: TextStyle(fontSize: 17)),
                  SizedBox(
                     height: 15,
            ),
                  Text('plants@gmail.com',
                  style: TextStyle(fontSize: 17,color: Colors.black)),
                  SizedBox(
                    height: 15,
            ),
                  Text('828 Sư Vạn Hạnh, phường 13, quận 10,Hồ Chí Minh',
                  style: TextStyle(fontSize: 17))
                ],
              ),
              )
             
            ],),SizedBox(
                  height: 25,
            ),
          ],
        ),
      ) ),
        Container(
           padding: EdgeInsets.all(20),
           child: Column(
             children: [
               Text('Liên hệ với chúng tôi',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily:'Itim',),),
               SizedBox(height: 20,),
                TextField(
                              style: TextStyle(fontSize: 18),
                              keyboardType: TextInputType.emailAddress,
                              controller: phoneController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white.withOpacity(0.9),
                                  filled: true,
                                  prefixIcon: Icon(Icons.email, color: Colors.teal.shade900,),
                                  hintText: 'Email',
                                  labelStyle: TextStyle(color:Colors.teal.shade900),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(color: Colors.grey.shade200)),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.all(Radius.circular(20)))
                                    ),
                            ),
               SizedBox(height: 20,),
              TextField(
                              style: TextStyle(fontSize: 18),
                              keyboardType: TextInputType.name,
                              controller: nameController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white.withOpacity(0.9),
                                  filled: true,
                                  prefixIcon: Icon(Icons.person, 
                                  color: Colors.teal.shade900,),
                                  hintText: 'Họ tên',
                                  labelStyle: TextStyle(color:Colors.teal.shade900),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200)),
                                  enabledBorder: OutlineInputBorder
                                  (borderSide: BorderSide(
                                    color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.all(Radius.circular(20)))
                                    ),
                            ),
                            SizedBox(height: 20,),
                            TextField(
                              maxLines:10,
                              style: TextStyle(fontSize: 18),
                              keyboardType: TextInputType.name,
                              controller: contentController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white.withOpacity(0.9),
                                  filled: true,
                                  
                                  
                                  hintText: 'Nội dung',
                                  labelStyle: TextStyle(color:Colors.teal.shade900),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200)),
                                  enabledBorder: OutlineInputBorder
                                  (borderSide: BorderSide(
                                    color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.all(Radius.circular(20)))
                                    ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 200,
                              child: MaterialButton( 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))) ,
                                onPressed: (){},
                                child:Text('Xác nhận',
                                style:TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Comfortaa',
                                  fontWeight:FontWeight.bold,
                                  color: Colors.white)) ,
                                color: Colors.teal.shade900,
                                hoverColor:Colors.teal.shade500 ,),
                            )

             ],
           ),
         )
            ],
      )
     ));
  }
}
