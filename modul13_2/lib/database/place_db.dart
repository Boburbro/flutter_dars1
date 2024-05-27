import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class PlaceDB {
  static Future<sql.Database> createDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, "baza.db"),
      onCreate: (db, version) => db.execute(
        "CREATE TABLE main (id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, long REAL, address TEXT)",
      ),
      version: 1,
    );
  }

  static Future<void> insert(
    Map<String, dynamic> data, {
    String table = "main",
  }) async {
    final db = await PlaceDB.createDatabase();
    await db.insert(
      table,
      data,
    );
  }

  static Future<List<Map<String, dynamic>>> getData({
    String table = "main",
  }) async {
    final db = await PlaceDB.createDatabase();
    return await db.query(table);
  }
}
