import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:raoroshanlalmarket/database/UserData.dart';

class Databasehelper {

  static final Databasehelper _databasehelper = Databasehelper.internal();

  factory Databasehelper() => _databasehelper;

  static Database _db;
  final String id = 'id';
  final String shopname = 'shopname';
  final String ownername = 'ownername';
  final String address = 'address';
  final String phoneno = 'phoneno';
  final String addimage = 'addimage';
  final String ownerimage = 'ownerimage';
  final String dbname = 'raouserc.db';
  final String table = 'raouser';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Databasehelper.internal();

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, dbname);

    var ourDb = openDatabase(path, version: 1, onCreate: _onCreate);

    return ourDb;
  }


  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $table($id INTEGER PRIMARY KEY,$shopname TEXT,$ownername TEXT,$address TEXT,$phoneno TEXT,$addimage BLOB,$ownerimage BLOB)");
  }

  Future<int> saveUser(UserData user) async {
    var dbClient = await db;
    int res = await dbClient.insert("$table", user.toMap());

    return res;
  }

  Future <List> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $table");
    return result.toList();
  }

  Future <List> gettwoUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT id, shopname,ownername FROM $table");
    return result.toList();
  }

  Future <int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  Future<UserData> getUser(int uid) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $table WHERE $id=$uid");

    if (result.length == 0) return null;
    return UserData.fromMap(result.first);

    //return UserData.fromMap(result.first);

  }

  Future<int> deleteUser(int d) async {
    var dbClient = await db;
    //return await dbClient.delete(table,where:"$id= ?",whereArgs:[id]);
    return await dbClient.rawDelete('DELETE FROM $table WHERE $id = $d');
  }

  Future <int> updateUser(UserData user) async {
    var dbClient = await db;
    return await dbClient.update(
        table, user.toMap(), where: " $id = ?", whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}