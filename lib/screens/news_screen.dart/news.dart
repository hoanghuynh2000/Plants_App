import 'package:flutter/material.dart';
import 'package:plants_app/model/mdnews.dart';
import 'package:plants_app/screens/news_screen.dart/detail_news.dart';

class News extends StatefulWidget {
  News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final _myListKey = GlobalKey<AnimatedListState>();
  List<MDNews> lsNews = [
    MDNews(
        id: '1',
        nameNews: 'Hướng dẫn chăm sóc',
        imageNews: 'assets/images/backgroundreset.jpg',
        detailNews: 'Những cách trồng cây hay nhất Việt Nam'),
    MDNews(
        id: '1',
        nameNews: 'Hướng dẫn chăm sóc',
        imageNews: 'assets/images/logo.png',
        detailNews: 'Những cách trồng cây hay nhất Việt Nam'),
    MDNews(
        id: '1',
        nameNews: 'Hướng dẫn chăm sóc',
        imageNews: 'assets/images/logo.png',
        detailNews:
            'Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam. Những cách trồng cây hay nhất Việt Nam.Những cách trồng cây hay nhất Việt NamNhững cách trồng cây hay nhất Việt Nam')
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 15, right: 15),
      color: Colors.grey.shade200,
      child: AnimatedList(
          key: _myListKey,
          initialItemCount: lsNews.length,
          itemBuilder: (context, index, animation) {
            return _itemNews(index);
          }),
    );
  }

  Widget _itemNews(int index) {
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
                        image: AssetImage('${lsNews[index].imageNews}'),
                        fit: BoxFit.fill)),
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
  }
}
