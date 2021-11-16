class Category {
  String? id;
  String? nameCate;
  dynamic imgCate;
  Category({this.id, this.nameCate, this.imgCate});
  factory Category.fromJson(Map<String,dynamic>json){
  return Category(
    id: json['MaLoai'],
    nameCate: json['TenLoai'],
    imgCate:json['imgLoai'],
    
  );
}
}
