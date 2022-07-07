import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'favs.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE favourites(id TEXT PRIMARY KEY)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DBHelper().database();
    await sqlDb.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await DBHelper().database();
    return sqlDb.query(table);
  }

  static Future<void> delete(String table, String id) async{
    final sqlDb = await DBHelper().database();
    await sqlDb.delete(table,where: "id = ?",whereArgs: [id]);
  }
}
