import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:plants_app/model/mdfavorites.dart';

class FavoritesDatabase  {
    static final FavoritesDatabase instance = FavoritesDatabase._init();
  String id='id';
  String isImportant='isImportant';
  String idProduct='idProduct';
  String productName='productName';
  String categoryName='categoryName';
  String price='price';
  String images='images';

  static Database? _database;

  FavoritesDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tablefavorites1.db');
    return _database!;
  }

  String tableFavorites='tablefavorites1';

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
  Future _createDB(Database db, int version) async {
    final idType = 'TEXT PRIMARY KEY';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('CREATE TABLE tablefavorites1 ($id $idType , $isImportant $integerType, $idProduct $textType, $productName $textType, $categoryName $textType, $price $integerType, $images $textType)');
  }
   Future<void> insertFav(Favorites favorites) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      'tablefavorites1',
      favorites.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
   Future<List<Favorites>> getFavById(String? id) async {
      final db = await database; 
      List<Map<String, dynamic>> maps = await db.query("tablefavorites1", where: 'id = ?', whereArgs: [id]); 
      
      return List.generate(maps.length, (i) {
      return Favorites(
        id: maps[i]['id'], 
        isImportant:  maps[i]['isImportant'], 
        idProduct:  maps[i]['idProduct'], 
        productName:  maps[i]['productName'], 
        categoryName:  maps[i]['categoryName'], 
        price:  maps[i]['price'], 
        images:  maps[i]['images']);
    });
   } 
 Future<List<Favorites>> readfavorites() async {
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('tablefavorites1');

    return List.generate(maps.length, (i) {
      return Favorites(
        id: maps[i]['id'], 
        isImportant:  maps[i]['isImportant'], 
        idProduct:  maps[i]['idProduct'], 
        productName:  maps[i]['productName'], 
        categoryName:  maps[i]['categoryName'], 
        price:  maps[i]['price'], 
        images:  maps[i]['images']);
    });
  }

  Future<void> updateFav(Favorites favorites) async {
    final db = await database;
    await db.update(
      'tablefavorites1',
      favorites.toMap(),
      where: 'id = ?',
      whereArgs: [favorites.id],
    );
  }

  Future<void> deleteFav(String? id) async {
    final db = await database;
    await db.delete(
      'tablefavorites1',
      where: 'idProduct = ?',
      whereArgs: [id],
    );
  }
  Future close() async{
    final db=await instance.database;
    return db.close();
  }
}
