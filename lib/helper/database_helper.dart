import 'package:cizaro_app/model/cartModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';

class DataBaseHelper {
  DataBaseHelper._();

  static final DataBaseHelper db = DataBaseHelper._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();

    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "CartData.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE $tableCart (
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnPrice Double,
      $columnPriceAfterDiscount Double,
      $columnCategoryName TEXT NOT NULL,
      $columnQuantity INTEGER,
      $columnMainImag TEXT NOT NULL,
      $columnAvailability INTEGER,
      $columnTotalPrice Double,
      $columnColorSpecs TEXT,
      $columnSizeSpecs TEXT,
      $columnInCart INTEGER NOT NULL  )
      ''');
    });
  }

  Future<void> addProductToCart(ProductCart productCart) async {
    var dbClient = await database;
    await dbClient.insert(
      tableCart,
      productCart.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updateProduct(ProductCart productCart) async {
    var dbClient = await database;
    await dbClient.update(tableCart, productCart.toJson(),
        where: '$columnId = ?', whereArgs: [productCart.id]);
  }

  Future<List<ProductCart>> getCartItems() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(tableCart);
    return maps.isNotEmpty
        ? maps.map((cart) => ProductCart.fromJson(cart)).toList()
        : [];
  }

  Future<void> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient
        .delete(tableCart, where: '$columnId = ?', whereArgs: [id]);
  }

  // Future<void> deleteTable() async {
  //   var dbClient = await database;
  //   return await dbClient.delete(tableCart);
  // }
}
