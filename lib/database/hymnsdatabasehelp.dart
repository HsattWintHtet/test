import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class FirstDatabaseHelper {
  static final FirstDatabaseHelper _instance =
      new FirstDatabaseHelper.internal();
  factory FirstDatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  FirstDatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "hymns.db");

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data =
          await rootBundle.load(join('assets', 'database', 'hymns.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }

    var ourDb = await openDatabase(path);
    return ourDb;
  }

  Future<List> getAllData() async {
    var dbClient = await db;
    String sql;
    sql = "SELECT * FROM hymns ORDER BY id ASC";

    var result = await dbClient.rawQuery(sql);
    return result;
  }

  Future<List> getBookMark() async {
    var dbClient = await db;
    String sql;
    sql = "SELECT * FROM hymns WHERE bookmark = 1";

    var result = await dbClient.rawQuery(sql);
    
    return result;
  }

  savebookMark(int id) async {
    var dbClient = await db;
    String sql;
    sql = "UPDATE hymns SET bookmark = 1 WHERE id = $id";
     await dbClient.rawUpdate(sql);

  }

  removebookMark(int id) async {
    var dbClient = await db;
    String sql;
    sql = "UPDATE hymns SET bookmark = 0 WHERE id = $id";
     await dbClient.rawUpdate(sql);

  }

  getBookMarkId(int id) async {
    var dbClient = await db;
    String sql;
    sql = "SELECT id FROM hymns WHERE bookmark = 1 and id=$id";
    List result = await dbClient.rawQuery(sql);
    if (result.length == 0) return 0;
    int getid = result[0]['id'];

    return getid;
  }

   getBookMarkResult(int id) async{
    var dbClient  = await db;
    String sql;
    sql = "SELECT bookmark FROM hymns WHERE id=$id";
    List result = await dbClient.rawQuery(sql);
    if(result.length == 0) return 0;
    int getid = result[0]['bookmark'];

    return getid;
  }
}
