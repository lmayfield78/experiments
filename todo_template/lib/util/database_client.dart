import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/todoItem.dart';


class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper.internal(); // Object constructor
  factory DatabaseHelper() => instance; // This allows us to use this instance of DatabaseHelper.
  final String tableName = "todoTbl";
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
    String path = join(documentDirectory.path, "todo_db.db"); // This will join the directory path and the db. "Main" is placeholder. Requires path.dart (ex.//home/directory/files/maindb.db
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
        "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnUsername TEXT, $columnPassword TEXT "); // method takes in sql query.
  }
  // CRUD - CREATE, READ, UPDATE, DELETE

  // Insertion
  Future<int> saveItem(ToDoItem item) async {
    /*
    //This function will connect to the database and
    pass through res that will map the new user to the table.
     */
    var dbClient = await db; // Connect to the db.
    int res = await dbClient.insert("$tableName", item.toMap()); // This will insert the user.toMap data into the tableUser table.
    return res;
  }

  //Get Users
  Future<List> getItems() async {
    /*
    This function will get all database
    users.
     */
    var dbClient = await db; // Connect to the db
    var result = await dbClient.rawQuery("SELECT * FROM $tableName"); // Query the table
    return result.toList(); // Made to list in case of any future issues.
  }

  Future<int> getCount() async{
    /*
      This function will query the table and return
      a user count.
     */
    var dbClient = await db; // Connect to the db.
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName")
    );
  }

  Future<User> getUser(int id) async {
    /*

     */
    var dbClient = await db; // Connect to the db.
    // Query the db and search for id.
    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");
    if(result.length == 0) return null;// locates users by id.
    return User.fromMap(result.first);// Return first result
  }

  Future<int> deleteUser(int id) async{
    /*
    This is method will delete a user from the table.
     */
    var dbClient = await db; // Connects to db.
    return await dbClient.delete(tableUser,
        where: "$columnId =?", whereArgs: [id]); // This will select column by list id.
  }

  Future<int> updateUser(User user) async {
    /*
    This method will update the user
     */
    var dbClient = await db; // connect to db
    return await dbClient.update(tableUser, user.toMap(),
        where: "$columnId = ?", whereArgs: [user.id]); // Select column to update.
  }

  Future close() async {
    // This method will close DB connection.
    var dbClient = await db;
    return dbClient.close();

  }

}