class mdShoppingCart{
  String? idGioHang;
  String? idKhachHang;
  mdShoppingCart({this.idGioHang,this.idKhachHang});
   Map<String, dynamic> toMap() {
    return {
      'id': idGioHang,
      'idShoppingCart': idKhachHang,
      
    };
    
  }
 mdShoppingCart.fromMap(Map<String, dynamic> res)
      : idGioHang = res["id"],
       idKhachHang=res['idKhachHang']
       ;
}