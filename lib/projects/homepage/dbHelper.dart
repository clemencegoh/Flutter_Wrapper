//import 'dart:async';
//import 'dart:io' as io;
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:path_provider/path_provider.dart';
//import 'projectsModel.dart';
//
//class DBHelper {
//  static Database _db;
//  static const String QUOTE = 'quote';
//  static const String AUTHOR = 'author';
//  static const String TABLE = 'Quotes';
//  static const String DB_NAME = 'homepageQuotes.db';
//
//  Future<Database> get db async {
//    if (_db != null) {
//      return _db;
//    }
//    _db = await initDb();
//    return _db;
//  }
//
//  initDb() async {
//    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, DB_NAME);
//    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//    return db;
//  }
//
//  _onCreate(Database db, int version) async {
//    await db
//        .execute("CREATE TABLE $TABLE ($QUOTE TEXT PRIMARY KEY, $AUTHOR TEXT)");
//  }
//
//  Future save(QuoteItem quoteItem) async {
//    var dbClient = await db;
//    await dbClient.insert(TABLE, quoteItem.toMap());
//    return quoteItem;
//    /*
//    await dbClient.transaction((txn) async {
//      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
//      return await txn.rawInsert(query);
//    });
//    */
//  }
//
//  Future<List<QuoteItem>> getAllQuotes() async {
//    var dbClient = await db;
//    List<Map> maps = await dbClient.query(TABLE, columns: [QUOTE, AUTHOR]);
//    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
//    List<QuoteItem> quotes = [];
//    if (maps.length > 0) {
//      for (int i = 0; i < maps.length; i++) {
//        quotes.add(QuoteItem.fromMap(maps[i]));
//      }
//    }
//    return quotes;
//  }
//
//  Future<int> delete(int id) async {
//    var dbClient = await db;
//    return await dbClient.delete(TABLE, where: '$QUOTE = ?', whereArgs: [id]);
//  }
//
//  Future<int> update(QuoteItem quoteItem) async {
//    var dbClient = await db;
//    return await dbClient.update(TABLE, quoteItem.toMap(),
//        where: '$QUOTE = ?', whereArgs: [quoteItem.quote]);
//  }
//
//  Future close() async {
//    var dbClient = await db;
//    dbClient.close();
//  }
//}