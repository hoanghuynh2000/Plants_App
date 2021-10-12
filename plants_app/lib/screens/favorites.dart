import 'package:flutter/material.dart';
import 'package:plants_app/model/mdfavorites.dart';
import 'package:plants_app/sqlite/favorites.dart';
class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<FavoritesScreen> {
  final data= FavoritesDatabase.instance;
 
 Favorites favorites= new Favorites(id: "1");
 // ignore: deprecated_member_use
 List<Favorites> listFav=[];
  void isFav() async{
        // await data.deleteFav(2);
      //await data.insertFav(new Favorites(id: "3", isImportant: 0, idProduct: '113', productName: 'XUong Rong', categoryName: 'categoryName', price: 120000, images: 'assets/images/brDangNhap.jpg'));
      await data.deleteFav('113');
       listFav=await data.readfavorites();
       print(await listFav);
     }
    @override
  void initState() {
    // TODO: implement initState
    
    super.initState();

  }
    @override
  Widget build(BuildContext context) {
    isFav();
    
    return ListView.builder(
        itemCount: listFav.length,
        itemBuilder: (context, index) {
          return Card(                         
            child: Container(
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            image:DecorationImage(
              image:AssetImage('assets/images/brDangNhap.jpg') ,
              fit: BoxFit.cover) ),
        ),
        Column(
          children: [
            Text('${listFav[index].productName}'),
            Text('${listFav[index].categoryName}'),
            Text('${listFav[index].price}')
          ],
        )
      ],),
    )
          );
        },
      );
  }
 
}