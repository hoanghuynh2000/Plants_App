import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:plants_app/model/mdfavorites.dart';
import 'package:plants_app/sqlite/favorites.dart';
class FavIcon extends StatefulWidget {
  final Favorites mydata;
  FavIcon(this.mydata);
  @override
  _FavIconState createState() => _FavIconState();
}

class _FavIconState extends State<FavIcon> {
  final data= FavoritesDatabase.instance;

  bool c=true;
  
    // ignore: unused_local_variable
   Future<bool>  isFav(bool isLiked) async{
      final rowsPresent = await data.getFavById(widget.mydata.idProduct);
    
       if (rowsPresent.length>0) {
         
          await data.deleteFav(widget.mydata.idProduct);
      return false;
    } else {
       await data.insertFav(widget.mydata);
      return true;
     }
    
    }
  @override
  Widget build(BuildContext context) {
  isFav;
    return 
    FutureBuilder(
        
        builder: (context, snapshot) {
             
              return LikeButton(
                onTap: isFav,
          size: 40,
          circleColor:
              CircleColor(start: Color(0xFFFF3C00), end: Color(0xFFFF3C00)),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Color(0xFFFF3C00),
            dotSecondaryColor: Color(0xFFFF3C00),
          ),
          likeBuilder: (bool isLiked) {
                   return  
                   Icon(Icons.favorite_sharp,color:isLiked? Colors.red:Colors.grey,size: 40,) ;
              });
         
        }
          
      );       
  }
}
