import 'package:cizaro_app/model/favModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'constants.dart';

class FavDataBaseHelper {
  FavDataBaseHelper._();

  static final FavDataBaseHelper db = FavDataBaseHelper._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();

    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "FavData.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE $tableFav (
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnPrice Double,
      $columnCategoryName TEXT ,
      $columnMainImag TEXT NOT NULL,
      $columnStars Double,
      $columnIsFav INTEGER NOT NULL  
       )
      ''');
    });
  }

  Future<void> addProductToFav(ProductFav productFav) async {
    var dbClient = await database;
    await dbClient.insert(
      tableFav,
      productFav.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updateProduct(ProductFav productFav) async {
    var dbClient = await database;
    await dbClient.update(tableFav, productFav.toJson(),
        where: '$columnId = ?', whereArgs: [productFav.id]);
  }

  Future<List<ProductFav>> getFavItems() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(tableFav);
    return maps.isNotEmpty
        ? maps.map((fav) => ProductFav.fromJson(fav)).toList()
        : [];
  }

  Future<void> deleteFavItem(int id) async {
    var dbClient = await database;
    return await dbClient
        .delete(tableFav, where: '$columnId = ?', whereArgs: [id]);
  }
}
