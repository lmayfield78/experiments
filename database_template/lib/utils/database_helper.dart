import 'dart:async';
import 'dart:io';
import 'package:database_template/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper.internal(); // Object constructor
  factory DatabaseHelper() => instance; // This allows us to use this instance of DatabaseHelper.
  final String tableUser = "userTable";
  final String columnId = "id";
  final String columnUsername = "username";
  final String columnPassword = "password";
  static Database _db;  // Database reference. Requires the sqflite import.




  Future<Database> get db async {
    /*
    - verify to see if a db exists on device. If so -> return that db
    - When db is verified, initialize the db.returned after initialized.
     */
    if(_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }


  static DatabaseHelper internal() {
    return null;
  }

  initDb() async {
    /*
    In order to create a db on device, you must locate the applications
     documents directory.

     */
    Directory documentDirectory = await getApplicationDocumentsDirectory(); // Locates the applications documents directory on device. Requires path_provider import.
    String path = join(documentDirectory.path, "maindb.db"); // This will join the directory path and the db. "Main" is placeholder. Requires path.dart (ex.//home/directory/files/maindb.db
    var ourDb = openDatabase(path, version: 1, onCreate: _onCreate); // This is the db variable.
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    /*
    When the db path is initiated, here it will now create the db table.
    id | username | password
    ------------------------
    1  | personA  | 12345
    2  | PersonB  | abc123
     */
    await db.execute(
        "CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY, $columnUsername TEXT, $columnPassword TEXT "); // method takes in sql query.
  }
  // CRUD - CREATE, READ, UPDATE, DELETE
  // Insertion
  Future<int> saveUser(User user) async {
    /*
    //Todo Explain how this function works.
     */
    var dbClient = await db;
    int res = await dbClient.insert("$tableUser", user.toMap());
    return res;
  }


}