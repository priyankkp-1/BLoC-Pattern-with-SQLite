import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final todoTableName = "todoData";

class DBProvider {
  static final DBProvider dbProvider = DBProvider();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "DataTodo.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDb, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {
      print("Your database is out deted");
    }
  }

  void initDb(Database db, int version) async {
    await db.execute("CREATE TABLE $todoTableName ("
        "id INTEGER PRIMARY KEY, "
        "description TEXT, "
        "isDone INTEGER "
        ")");
  }
}
