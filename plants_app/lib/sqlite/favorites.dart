import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:plants_app/model/mdfavorites.dart';

class FavoritesDatabase {
  static final FavoritesDatabase instance = FavoritesDatabase._init();

  static Database? _database;

  FavoritesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('favorites.db');
    return _database!;
  }

  get tableFavorites => null;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE ${tableFavorites} ( 
  ${FavoritesFields.id} $idType, 
  ${FavoritesFields.isImportant} $boolType,
  ${FavoritesFields.idProduct} $textType,
  ${FavoritesFields.productName} $textType,
  ${FavoritesFields.categoryName} $textType,
  ${FavoritesFields.price} $integerType,
  ${FavoritesFields.images} $textType
  )
''');
  }

  Future<Favorites> create(Favorites favorites) async {
    final db = await instance.database;

    // final json = favorites.toJson();
    // final columns =
    //     '${FavoritesFields.title}, ${FavoritesFields.description}, ${FavoritesFields.time}';
    // final values =
    //     '${json[FavoritesFields.title]}, ${json[FavoritesFields.description]}, ${json[FavoritesFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableFavorites, favorites.toJson());
    return favorites.copy(id: id);
  }

  Future<Favorites> readFavorites(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFavorites,
      columns: FavoritesFields.values,
      where: '${FavoritesFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return Favorites.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Favorites>> readAllFavorites() async {
    final db = await instance.database;

    final orderBy = '${FavoritesFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableFavorites ORDER BY $orderBy');

    final result = await db.query(tableFavorites, orderBy: orderBy);

    return result.map((json) => Favorites.fromJson(json)).toList();
  }

  Future<int> update(Favorites favorites) async {
    final db = await instance.database;

    return db.update(
      tableFavorites,
      favorites.toJson(),
      where: '${FavoritesFields.id} = ?',
      whereArgs: [favorites.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableFavorites,
      where: '${FavoritesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

