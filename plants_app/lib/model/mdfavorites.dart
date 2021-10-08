final String tableNotes = 'notes';

class FavoritesFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, productName, categoryName, price, images,idProduct
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String idProduct = 'idProduct';
  static final String productName = 'productName';
  static final String categoryName = 'categoryName';
  static final String price = 'price';
  static final String images='images';
  static final String time='time';
}

class Favorites {
  final int? id;
  final bool isImportant;
  final String idProduct;
  final String productName;
  final String categoryName;
  final int price;
  final String images;
  final DateTime time;

  const Favorites 
({
    this.id,
    required this.isImportant,
    required this.idProduct,
    required this.productName,
    required this.categoryName,
    required this.price,
    required this.images,
    required this.time,
  });

Favorites
 copy({
    int? id,
    bool? isImportant,
    String? idProduct,
    String? productName,
    String? categoryName,
    int? price,
    String? images,
    DateTime? time
  }) =>
      Favorites(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        idProduct: idProduct ?? this.idProduct,
        productName: productName??this.productName,
        categoryName: categoryName??this.categoryName,
        price: price??this.price,
        images: images??this.images,
        time: time ?? this.time,
      );

 static Favorites fromJson(Map<String, Object?> json) => Favorites(
        id: json[FavoritesFields.id] as int?,
        isImportant: json[FavoritesFields.isImportant] == 1,
        idProduct: json[FavoritesFields.idProduct] as String,
        productName: json[FavoritesFields.productName] as String,
        categoryName: json[FavoritesFields.categoryName] as String,
        price:json[FavoritesFields.price] as int,
        images:json[FavoritesFields.images] as String,
        time: DateTime.parse(json[FavoritesFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        FavoritesFields.id: id,
        FavoritesFields.productName: productName,
        FavoritesFields.isImportant: isImportant ? 1 : 0,
        FavoritesFields.idProduct: idProduct,
        FavoritesFields.categoryName: categoryName,
        FavoritesFields.price: price,
        FavoritesFields.images:images,
        FavoritesFields.time: time.toIso8601String(),
      };

}