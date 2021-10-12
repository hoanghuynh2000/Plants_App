
class Favorites {
  final String? id;
  final int? isImportant;
  final String? idProduct;
  final String? productName;
  final String? categoryName;
  final int? price;
  final String? images;

Favorites 
({
    required this.id,
     this.isImportant,
     this.idProduct,
     this.productName,
     this.categoryName,
     this.price,
     this.images,
  });
 
 // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isImportant': isImportant,
      'idProduct':idProduct,
      'productName': productName,
      'categoryName': categoryName,
      'price':price,
      'images':images
    };
    
  }
 Favorites.fromMap(Map<String, dynamic> res)
      : id = res["id"],
       isImportant=res['isImportant'],
       idProduct=res['idProduct'],
       productName=res['productName'],
       categoryName=res['categoryName'],
       price=res['price'],
       images=res['images'];
}