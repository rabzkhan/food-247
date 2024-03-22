import 'package:food/core/database/db_consts.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../components/toast_message.dart';
import '../controllers/cart_controller.dart';
import '../models/cart_model.dart';

class DatabaseRepository {
  CartController cartController = Get.find();
  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();

  Database? _database;
  //check if db is created it yes then returns it, if no then creates one
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cartItems.db');
    return _database!;
  }

  // initializing db
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //create db with rules and fileds
  Future _createDB(Database db, int version) async {
    await db.execute('''
    create table ${DbConst.tableName} ( 
      ${DbConst.id} integer primary key autoincrement, 
      ${DbConst.productId} integer not null, 
      ${DbConst.title} text not null,
      ${DbConst.description} text not null,
      ${DbConst.imageUrl} text not null,
      ${DbConst.quantity} integer not null,
      ${DbConst.price} double not null)
      '''); // <-- Add closing parenthesis here
  }

  Future<List<CartModel>> getCartList() async {
    final db = await instance.database;
    final result = await db.query(DbConst.tableName);
    return result.map((json) => CartModel.fromJson(json)).toList();
  }

  Future<void> insert({required CartModel cart}) async {
    try {
      final db = await database;
      final existingItem = await db.query(DbConst.tableName, where: 'productId = ?', whereArgs: [cart.productId]);
      if (existingItem.isEmpty) {
        await db.insert(DbConst.tableName, cart.toMap());
        showToast("Product added to cart!");
      } else {
        showToast("Product already in cart!");
      }
    } catch (e) {
      Logger().d(e.toString());
    } finally {
      cartController.getCartItems();
    }
  }

  Future<void> delete(int productId) async {
    try {
      final db = await instance.database;
      await db.delete(
        DbConst.tableName,
        where: '${DbConst.productId} = $productId',
        whereArgs: [],
      );
      showToast("Product removed from cart!");
    } catch (e) {
      Logger().d(e.toString());
    } finally {
      cartController.getCartItems();
    }
  }

  Future<void> update(CartModel cart) async {
    try {
      final db = await instance.database;
      db.update(
        DbConst.tableName,
        cart.toMap(),
        where: '${DbConst.productId} = ${cart.productId}',
        whereArgs: [],
      );
    } catch (e) {
      Logger().d(e.toString());
    } finally {
      cartController.getCartItems();
    }
  }
}
