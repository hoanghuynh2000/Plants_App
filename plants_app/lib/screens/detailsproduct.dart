import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:intl/intl.dart';
import 'package:plants_app/fake/feedfake.dart';
import 'package:plants_app/model/mdfeedback.dart';
import 'package:plants_app/screens/feedback.dart';
class DetailsProduct extends StatefulWidget {
  DetailsProduct({Key? key}) : super(key: key);

  @override
  _DetailsProductState createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  
  @override
  Widget build(BuildContext context) {
    
    double height= MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    String TenSanPham='Tên Sản Phẩm';  
  String GiaSanPham='123.000';
  String DanhMucSanPham='Danh Muc San Pham';
    String id='idSanPham';
    return  Container(
      decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment(0.0,0.0),colors:[Color(0xFF009688),Color(0xFFffffff)])),
      child: 
      Scaffold(
        backgroundColor:Colors.transparent,
       persistentFooterButtons: <Widget>[
         
         Container(
           decoration:BoxDecoration(color: Colors.white),
         child: Row(children: [
           SizedBox(width: 40,),
           //nút Yêu thích.
          LikeButton(
          size: 40,
          circleColor:
              CircleColor(start: Color(0xFFFF0000), end: Color(0xFFCC0000)),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Color(0xFFE53333),
            dotSecondaryColor: Color(0xFFCC0000),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.favorite_sharp,
              color: isLiked ? Colors.red : Colors.grey,
              size: 40,
            );
          },
        ),
        SizedBox(width: 40,),
        MaterialButton(onPressed: (){},
           child: Text('Thêm Vào Giỏ Hàng',style: TextStyle(color: Colors.white,fontFamily:'Rokkitt',fontSize: 24)),
           color: Colors.teal.shade800,
           height: 50,
           minWidth: width*0.6,
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0))
           ,),
         ],)
         ) 
      ],
      // each product have a color
      //backgroundColor:Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors:[Color(Colors.blue),Color(Colors.white)])),) ,
      appBar: buildAppBar(context),
      body:SingleChildScrollView(
      child: Column(
        children: <Widget>[
           Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: height * 0.25),
                  padding: EdgeInsets.only(
                    top: height * 0.05,
                  ),
                   height: height/1.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      
                    ),
                  ),
                 child:  ProductTitleWithImage(),
                ),Container(
                  padding: EdgeInsets.only(left: 20),
                 
                ),
             
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
         
                  SizedBox(
                    width:width/3 ,
                  ),
                    Expanded(
                child: Hero(
                  tag: "${id}",
                  child: Image.asset('${"assets/images/cay1.png"}',
                    fit: BoxFit.cover,
                  ),
                ),  
              ),
                  
                   SizedBox(
                    width:width/9 ,
                  ),
                ],)
              
              ],
            ),
          
        ],
      ),
      )
    ));
  }
  //AppBar chi tiết sản phẩm
   AppBar buildAppBar(BuildContext context) {
     
    return AppBar(
      backgroundColor: Colors.teal.shade400,
      elevation: 0,
      
      actions: <Widget>[
        IconButton(
          iconSize: 30,
          color: Colors.teal.shade900,
          icon: Icon(Icons.shopping_basket,),
          onPressed: () {},
        ),
       
      ],
    );
  }
}
class Feedback extends StatelessWidget {
List<MDFeedback> mdFeedback=FakeFeedback.where((element) => element.idSanPham == '123').toList();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mdFeedback.length,
        itemBuilder: (context, index) {
          return Container( //                           
            child: ItemFeedback(mdFeedback: mdFeedback[index])
          );
        },
      );
    
    // return GridView(scrollDirection: Axis.vertical,
    //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: 300,
    //     childAspectRatio: 1,
    //     mainAxisSpacing: 15,
    //     crossAxisSpacing: 12),
    //     children: mdFeedback.map((e) => ItemFeedback(mdFeedback: e)).toList());
          
  }
}
class ItemFeedback extends StatelessWidget {
   MDFeedback mdFeedback=new MDFeedback();
  ItemFeedback({required this.mdFeedback});
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Container(
      padding:EdgeInsets.only(top: 5,bottom: 5),
      margin: EdgeInsets.only(top: 5,bottom: 5),
      decoration: BoxDecoration(color: Colors.grey.shade200,
        borderRadius: BorderRadius.all(
          Radius.circular(15))),
      
      child: Row(
        
        children: [
         SizedBox(width: 10,),
          Column(
            children: [
              SizedBox(width: 10,),
              Row(children: [
                 Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),image:DecorationImage(image: AssetImage('${mdFeedback.anhKhachHang}',),fit: BoxFit.fill),),
                  height: 40,
                  width: 40,
            
          ),
              SizedBox(width: 10,),
                Container( 
                  width: width/2,
                  height: 20,
                  child: Text('${mdFeedback.tenKhachHang}',
                  style: 
                  TextStyle(
                    fontSize: 16,
                    fontWeight:FontWeight.bold ),))
             ,
              Container(
                width:width*0.23 ,
                child: 
                Text('${mdFeedback.ngay}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,),))
              ],),
              SizedBox(height: 10,),
              Container(
                width: width*0.8,
                  child: Text('${mdFeedback.noiDung}')
              ),
              SizedBox(height: 10,)
            ],
          )
        ],
      ),
    );
  }
}
class ProductTitleWithImage extends StatelessWidget {
  String TenSanPham='Tên Sản Phẩm';  
  int GiaSanPham=123000;
  String DanhMucSanPham='Danh Muc San Pham';
  String HinhSanPham='Hinh San Pham';
  String MoTaChiTietSanPham='Mô tả chi tiết sản phẩm ........................................................................................................................................................';
 
  @override
  Widget build(BuildContext context) {
    
  double width= MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Column(
                    children: [
                      
                       Text(
            '${TenSanPham}',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25),
          ),
           SizedBox(height: 10),
          Text(
            '${DanhMucSanPham}',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.teal.shade700, fontWeight: FontWeight.bold,fontSize: 17),
          ),
                    ],
                  ),
          SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${NumberFormat('###,###').format(GiaSanPham)} VND',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold,fontSize: 25),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CartCounter(),
              SizedBox(height: 20),
              Text('Mô Tả Sản Phẩm',style: TextStyle(fontSize: 20,color: Colors.teal.shade900,fontWeight: FontWeight.bold),),
              SizedBox(height: 10),              
              Text("${MoTaChiTietSanPham}"),
              SizedBox(height: 20),
              Text('Đánh Giá Sản Phẩm',style: TextStyle(fontSize: 20,color: Colors.teal.shade900,fontWeight: FontWeight.bold),),
              Expanded(
                child: Feedback(),
              )
        ],
      ),
    );
  }
}
class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            '${numOfItems}',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                if(numOfItems<20)
                {
                numOfItems++;
                }
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({required IconData icon, required Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      // ignore: deprecated_member_use
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed:(){press;} ,
        child: Icon(icon),
      ),
    );
  }
}