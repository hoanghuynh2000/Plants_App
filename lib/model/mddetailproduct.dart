class DetailProduct {
  String? id;
  String? namePro;
  dynamic pricePro;
  String? descrip;
  dynamic quantity;
  dynamic imgProduct;
  dynamic idCate;
  String? state;
  DetailProduct(
      {this.id,
      this.namePro,
      this.pricePro,
      this.descrip,
      // this.status,
      this.quantity,
      this.imgProduct,
      this.idCate,
      this.state});
      factory DetailProduct.fromJson(Map<String,dynamic>json){
  return DetailProduct(
    id: json['MaSp'],
    namePro: json['TenSp'],
    pricePro:json['GiaSp'],
    descrip: json['MoTaChiTiet'],
    idCate: json['TenLoai'],
    imgProduct: json['ImageURL'],
    state: json['TinhTrang'],
    quantity: json['SoluongSp'],

  );
}
}
