class mdDetailOrder{
  String? namePro;
  String? imagePro;
  String? idKhachHang;
  String? quantity;
  String? price;
  String?idOrder;
  String? idPro;
  mdDetailOrder({this.idKhachHang,this.idOrder,this.quantity,this.price,this.idPro,this.imagePro,this.namePro});
  Map<String, dynamic> toMap() {
    return {
      'namePro':namePro,
      'imagePro':imagePro,
      'idKhachHang':idKhachHang,
      'quantity':quantity,
      'totalPrice':price,
      'idOrder':idOrder,
      'idPro':idPro,

    };
  }
  factory mdDetailOrder.fromJson(Map<String,dynamic>json){
    return mdDetailOrder(
      namePro: json['namePro'],
      imagePro: json['imagePro'],
      idKhachHang: json['idKhachHang'],
      quantity: json['quantity'],
      price:json['totalPrice'],
      idPro: json['idPro'],
      idOrder: json['idOrder'],
    );
  }
}