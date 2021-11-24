class MDNews {
  String? id;
  String? nameNews;
  String? imageNews;
  String? detailNews;
  MDNews({this.id, this.nameNews, this.imageNews, this.detailNews});
  factory MDNews.fromJson(Map<String,dynamic>json){
  return MDNews(
    id: json['MaTT'],
    nameNews: json['TenTT'],
    imageNews:json['ImageTTURL'],
    detailNews: json['NoiDungTT'],
   
  );
}
}
