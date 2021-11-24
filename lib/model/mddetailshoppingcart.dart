
class MDDetailShoppingCart {
  dynamic idKhachHang;
  dynamic quantity;
  dynamic idProduct;
  dynamic productName;
  dynamic categoryName;
  dynamic price;
  dynamic images;

MDDetailShoppingCart 
({
     this.idKhachHang,
     this.quantity,
     this.idProduct,
     this.productName,
     this.categoryName,
     this.price,
     this.images,
  });
 
 // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'idKhachHang': idKhachHang,
      'idProduct':idProduct,
      'productName': productName,
      'categoryName': categoryName,
      'price':price,
      'images':images,
      'quantity':quantity
    };
    
  }
 factory MDDetailShoppingCart.fromJson(Map<String, dynamic> res)
 {  
   return MDDetailShoppingCart( 
     
     idKhachHang : res["idKhachHang"],
       quantity:res['quantity'],
       idProduct:res['idProduct'],
       productName:res['productName'],
       categoryName:res['categoryName'],
       price:res['price'],
       images:res['images']);
 }
     
}