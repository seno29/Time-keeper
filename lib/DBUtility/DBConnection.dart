import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConnection {
  static Database database;
  static Future<Database> openDatabaseConnection() async {
    // await deleteDatabase(join(await getDatabasesPath(), 'timer_database.db'));
    database = await openDatabase(
      join(await getDatabasesPath(), 'timer_database.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, tag TEXT, status TEXT, priority INTEGER, date TEXT)');
        db.execute('CREATE TABLE tags(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
        db.execute('CREATE TABLE timer(id INTEGER PRIMARY KEY AUTOINCREMENT, taskid INTEGER, duration INTEGER, date TEXT)');
        // db.execute('CREATE TABLE badges(id INTEGER PRIMARY KEY AUTOINCREMENT, desc TEXT)');
      },
      version: 1,
    );
    return database;
  }

  void closeDatabase() async{
    if(database != null){
      await database.close();
    }
  }
}
