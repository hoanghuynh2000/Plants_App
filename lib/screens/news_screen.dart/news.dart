import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/firebase/news.dart';
import 'package:plants_app/firebase/promotion.dart';
import 'package:plants_app/model/mdnews.dart';
import 'package:plants_app/model/mdpromotion.dart';
import 'package:plants_app/screens/news_screen.dart/detail_news.dart';

class News extends StatefulWidget {
  News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final _myListKey = GlobalKey<AnimatedListState>();
 List<MDNews> lsNews = [];
 List<MDPromotion> lsPro = [];
  
   
  FetchData()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    dynamic result= await FirNews().getListNews();
    if(result==null){
      print('unable');
    }else{
      setState(() {
        lsNews=result;
      });
    }
  }
  @override
  void initState(){
    super.initState();
    FetchData();

  }
  @override
  Widget build(BuildContext context) {
    print(lsNews);
    return Material(
      child:  Container(
      // padding: EdgeInsets.only(left: 15, right: 15),
      color: Colors.grey.shade200,
      child: ListView.builder(
         // key: _myListKey,
         // initialItemCount: lsNews.length,
         itemCount: lsNews.length,
          itemBuilder: (context, index) {
            print(lsNews[index].nameNews);
           return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailNews(news: lsNews[index])));
        },
        child: Container(
          padding: EdgeInsets.all(7),
          margin: EdgeInsets.only(top: 10, left: 16, right: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: ShapeDecoration(
                    color: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    image: DecorationImage(
                        image: NetworkImage('${lsNews[index].imageNews}'),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${lsNews[index].nameNews}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${lsNews[index].detailNews}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey.shade600),
                          )
                        ],
                      )))
            ],
          ),
        ));
          }),
    )
   ,
    );
  }

  // Widget _itemNews(int index) {
    
  // }
}
