import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? database;

  Future<Database?> checkDB() async {
    if (database != null) {
      return database;
    } else {
      return await initDB();
    }
  }

  Future<Future<Database>> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "rnw.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE todo (id INTEGER PRIMARY KEY AUTOINCREMENT,priority TEXT,title TEXT,notes TEXT,date TEXT,time TEXT)";
        db.execute(query);
      },
    );
  }

  void insertData(
      {required priority,
      required notes,
      required date,
      required time,
      required title}) async {
    database = await checkDB();
    database!.insert("todo", {
      "notes": notes,
      "date": date,
      "time": time,
      "priority": priority,
      "title": title
    });
  }

  Future<List<Map>> readData() async {
    database = await checkDB();
    String query = "SELECT * FROM todo";
    List<Map> list = await database!.rawQuery(query);
    print(list);
    return list;
  }

  Future<void> deleteData({required id}) async {
    database = await checkDB();
    database!.delete("todo", where: "id=?", whereArgs: [id]);
  }

  Future<void> updateDate(
      {required priority,
      required notes,
      required date,
      required time,
      required title,
      required id}) async {
    database = await checkDB();
    database!.update(
        "todo",
        {
          "priority": priority,
          "notes": notes,
          "date": date,
          "time": time,
        },
        whereArgs: [id],
        where: "id=?");
  }
}
