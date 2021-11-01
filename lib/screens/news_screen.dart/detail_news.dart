import 'package:flutter/material.dart';
import 'package:plants_app/model/mdnews.dart';

class DetailNews extends StatefulWidget {
  //DeatilNews({Key? key}) : super(key: key);
  MDNews? news;
  DetailNews({this.news});
  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[Colors.teal.shade900, Colors.teal.shade600])),
        ),
        title: Text(
          'Thông Tin Tin Tức',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              child: Stack(
        children: [
          Container(
            height: size.height * (1 / 3) + 50,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('${widget.news!.imageNews}'),
                    fit: BoxFit.cover)),
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: size.width,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)))),
            margin: EdgeInsets.only(top: size.height * (1 / 3)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.news!.nameNews}',
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${widget.news!.detailNews}',
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade800),
                ),
              ],
            ),
          )
        ],
      ))),
    );
  }
}
