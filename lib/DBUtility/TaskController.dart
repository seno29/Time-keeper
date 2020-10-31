import 'package:sqflite/sqflite.dart';
import 'package:time_keeper/DBUtility/DBConnection.dart';
import 'package:time_keeper/Models/DoughnutChartData.dart';
import 'package:time_keeper/Models/BarChartData.dart';
import 'package:time_keeper/Models/Tag.dart';
import 'package:time_keeper/Models/Task.dart';
import 'package:time_keeper/Models/Timer.dart';

class TaskController {
  static Future<int> insertTask(Task task) async {
    Database db = await DBConnection.openDatabaseConnection();
    return db.insert('tasks', task.toMap());
  }

  static Future<List<Task>> getPendingTask() async {
    Database db = await DBConnection.openDatabaseConnection();
    List<Map<String, dynamic>> tasks =
        await db.query('tasks', where: "status = 'Pending'");
    return List.generate(
        tasks.length,
        (i) => Task(
            id: tasks[i]['id'],
            title: tasks[i]['title'],
            tag: tasks[i]['tag'],
            status: tasks[i]['status'],
            priority: tasks[i]['priority'],
            dateCreated: DateTime.parse(tasks[i]['date'])));
  }

  static Future<List<Task>> getCompletedTask() async {
    Database db = await DBConnection.openDatabaseConnection();
    List<Map<String, dynamic>> tasks =
        await db.query('tasks', where: "status = 'Completed'");
    // print(tasks[0]['date']);
    return List.generate(
        tasks.length,
        (i) => Task(
            id: tasks[i]['id'],
            title: tasks[i]['title'],
            tag: tasks[i]['tag'],
            status: tasks[i]['status'],
            priority: tasks[i]['priority'],
            dateCreated: DateTime.parse(tasks[i]['date'])));
  }

  static Future<int> deleteTask(int id) async {
    Database db = await DBConnection.openDatabaseConnection();
    return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> editTask(int id, Task task) async {
    Database db = await DBConnection.openDatabaseConnection();
    return db.update('tasks', task.toMap(), where: 'id=?', whereArgs: [id]);
  }

  static void initTag() async {
    Database db = await DBConnection.openDatabaseConnection();
    db.insert('tags', {'name': 'Study'});
    db.insert('tags', {'name': 'Work'});
    db.insert('tags', {'name': 'Sports'});
    db.insert('tags', {'name': 'Meditation'});
    db.insert('tags', {'name': 'Assignment'});
  }

  static Future<List<Tag>> getTags() async {
    // initTag();
    Database db = await DBConnection.openDatabaseConnection();
    List<Map<String, dynamic>> tagMap = await db.query('tags');
    return List.generate(
      tagMap.length,
      (i) => Tag(
        id: tagMap[i]['id'],
        name: tagMap[i]['name'],
      ),
    );
  }

  static Future<int> insertTag(Tag tag) async {
    Database db = await DBConnection.openDatabaseConnection();
    return db.insert('tags', tag.toMap());
  }

  static Future<int> addTimer(TimerData timer) async {
    Database db = await DBConnection.openDatabaseConnection();
    int res = await db.insert('timer', timer.toMap());
    return res;
  }

  static Future<int> updateTaskStatus(int id, String status) async {
    Database db = await DBConnection.openDatabaseConnection();
    return db.update('tasks', {'status': '$status'},
        where: 'id=?', whereArgs: [id]);
  }

  static Future<int> getTotalFocusTime() async {
    Database db = await DBConnection.openDatabaseConnection();
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT sum(duration) as totalDuration from timer');
    return result[0]['totalDuration'];
  }

  static Future<int> getTotalPendingTask() async {
    Database db = await DBConnection.openDatabaseConnection();
    List<Map<String, dynamic>> result = await db
        .rawQuery("SELECT count(*) as total from tasks where status='Pending'");
    return result[0]['total'];
  }

  static Future<int> getTotalCompletedTask() async {
    Database db = await DBConnection.openDatabaseConnection();
    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT count(*) as total from tasks where status='Completed'");
    return result[0]['total'];
  }

  static Future<int> getTotalTodaysPendingTask() async {
    Database db = await DBConnection.openDatabaseConnection();
    DateTime currentDate = DateTime.now();
    List<Map<String, dynamic>> result = await db
        .rawQuery("SELECT count(*) as total from tasks WHERE status='Pending' AND date LIKE '${currentDate.year}-${currentDate.month}-${currentDate.day}%'");
    return result[0]['total'];
  }

  static Future<int> getTotalTodaysCompletedTask() async {
    Database db = await DBConnection.openDatabaseConnection();
    DateTime currentDate = DateTime.now();
    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT count(*) as total from tasks WHERE status='Completed' AND date LIKE '${currentDate.year}-${currentDate.month}-${currentDate.day}%'");
    return result[0]['total'];
  }

  static Future<List<DoughnutChartData>> getChartData() async {
    Database db = await DBConnection.openDatabaseConnection();
    DateTime currentDate = DateTime.now();  
    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT tag,sum(duration) as duration from Timer INNER JOIN Tasks ON Timer.taskid=Tasks.id WHERE Timer.date LIKE '${currentDate.year}-${currentDate.month}-${currentDate.day}%' GROUP BY Tasks.tag");
    return List.generate(
      result.length,
      (i) => DoughnutChartData(
        tag: result[i]['tag'],
        duration: result[i]['duration'],
      ),
    );
  }

  static Future<List<BarChartData>> getBarChartData() async {
    Database db = await DBConnection.openDatabaseConnection();
    DateTime currentDate = DateTime.now();
    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT date,sum(duration) as duration from TIMER WHERE date LIKE '${currentDate.year}-${currentDate.month}-%' GROUP BY date");
    return List.generate(result.length, (i) {
      DateTime dateFromString = DateTime.parse(result[i]['date']);
      return BarChartData(
        date: dateFromString.day,
        duration: result[i]['duration'],
      );
    });
  }
}
