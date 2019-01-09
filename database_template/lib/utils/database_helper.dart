import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper.internal();

  factory DatabaseHelper() => instance;

  final String tableUser = "userTable";
  final String columnId = "id";
  final String columnUsername = "username";
  final String columnPassword = "password";

  static Database _db;

  Future<Database> get db async {
    if(_db != null) {

      return _db;
    }
    _db = await initDb();

    return _db;

  }

  static DatabaseHelper internal() {}

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "maindb.db");

    var ourDB = openDatabase(path, version: 1, onCreate: _onCreate);

    
  }

    void _onCreate(Database db, int version) async {

    await db.execute(
        "CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY, $columnUsername TEXT, $columnPassword TEXT ");
  }
}