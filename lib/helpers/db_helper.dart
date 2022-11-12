import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';
import '../model/quot.dart';
import 'api_helper.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();
  final String dbName = "quotes.db";
  final String colId = "id";
  final String colQuot = "quote";
  final String colAuthor = "author";
  final String colImage = "image";
  Database? db;

  Future<void> initDB({required String tableName}) async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbName);
    db = await openDatabase(path, version: 1, onCreate: (db, version) async {});
    await db?.execute(
        "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colQuot TEXT,$colAuthor TEXT, $colImage BLOB)");
  }

  insertRecord({required String tableName}) async {
    await initDB(tableName: tableName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isInserted = prefs.getBool(tableName) ?? false;

    if (isInserted == false) {
      List<Quot>? res =
          await QuotesAPI.quotesAPI.fetchQuotes(tableName: tableName);

      for (int i = 0; i < res!.length; i++) {
        String query =
            "INSERT INTO $tableName($colQuot, $colAuthor, $colImage) VALUES(?, ?, ?)";
        List args = [res[i].quot, res[i].author, res[i].image];
        await db?.rawInsert(query, args);
      }
      prefs.setBool(tableName, true);
    }
  }

  Future<List<DBQuot>> fetchAllRecords({required String tableName}) async {
    await insertRecord(tableName: tableName);
    String query = "SELECT * FROM $tableName";
    List<Map<String, dynamic>> allQuotes = await db!.rawQuery(query);
    List<DBQuot> quotes = allQuotes.map((e) => DBQuot.fromJSON(e)).toList();
    Global.isAuthor = false;
    return quotes;
  }
}
