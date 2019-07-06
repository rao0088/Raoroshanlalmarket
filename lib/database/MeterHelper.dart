import 'package:path/path.dart';
import 'package:raoroshanlalmarket/database/MeterData.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
class Meterhelper {

  static final Meterhelper _meterhelper = Meterhelper.internal();

  factory Meterhelper() => _meterhelper;

  static Database _db;
  final String id = 'id';
  final String shopid = 'shopid';
  final String monthyear = 'monthyear';
  final String date = 'date';
  final String meterimage = 'meterimage';
  final String meterreading = 'meterreading';
  final String dbname = 'metersdetails.db';
  final String table = 'metersdates';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Meterhelper.internal();

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, dbname);

    var ourDb = openDatabase(path, version: 2, onCreate: _onCreate);

    return ourDb;
  }


  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $table($id INTEGER PRIMARY KEY,$shopid INTEGER,$monthyear TEXT,$date TEXT,$meterimage BLOB,$meterreading TEXT)");
  }

  Future<int> saveUser(MeterData user) async {
    var dbClient = await db;
    int res = await dbClient.insert("$table", user.toMap());

    return res;
  }

  Future <List> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $table");
    return result.toList();
  }

  Future <List> getUserslist(int uid,) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $table WHERE $shopid=$uid");
    return result.toList();
  }

  Future <int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  Future<MeterData> getUser(int uid) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $table WHERE $shopid=$uid");

    if (result.length == 0) return null;
    return MeterData.fromMap(result.first);

    //return UserData.fromMap(result.first);

  }


  Future<MeterData> getMeterData(int uid, String month) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $table WHERE $shopid=$uid AND $monthyear="+"'$month'",null);

    if (result.length == 0) return null;
    return MeterData.fromMap(result.first);

    //return UserData.fromMap(result.first);

  }


  Future<MeterData> getMonthYear(int uid,String month) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT monthyear FROM $table WHERE $shopid=$uid AND $monthyear="+"'$month'",null);

    if (result.length == 0) return null;
    return MeterData.fromMap(result.first);

  }

  Future<int> deleteUser(int d) async {
    var dbClient = await db;
    //return await dbClient.delete(table,where:"$id= ?",whereArgs:[id]);
    return await dbClient.rawDelete('DELETE FROM $table WHERE $id = $d');
  }

  Future <int> updateUser(MeterData user) async {
    var dbClient = await db;
    return await dbClient.update(
        table, user.toMap(), where: " $id = ?", whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}