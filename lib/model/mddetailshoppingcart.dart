
class MDDetailShoppingCart {
  final String? id;
  String? idShoppingCart;
  String? quantity;
  final String? idProduct;
  final String? productName;
  dynamic categoryName;
  dynamic price;
  final String? images;

MDDetailShoppingCart 
({
    required this.id,
     this.quantity,
     this.idProduct,
     this.productName,
     this.categoryName,
     this.price,
     this.images,
     this.idShoppingCart
  });
 
 // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idShoppingCart': idShoppingCart,
      'idProduct':idProduct,
      'productName': productName,
      'categoryName': categoryName,
      'price':price,
      'images':images,
      'quantity':quantity
    };
    
  }
 MDDetailShoppingCart.fromMap(Map<String, dynamic> res)
      : id = res["id"],
       quantity=res['quantity'],
       idProduct=res['idProduct'],
       productName=res['productName'],
       categoryName=res['categoryName'],
       price=res['price'],
       images=res['images'],
       idShoppingCart=res['idShoppingCart'];
}