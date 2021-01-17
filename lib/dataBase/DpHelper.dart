import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:assiment3/TaskModel.dart';

class DatabaseHelper {
  static DatabaseHelper helperdata;
  static Database db;
  String taskTable = "taskTable";
  String id = "id";
  String taskName = "taskName";
  String isDone = "isDone";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (helperdata == null) {
      helperdata = DatabaseHelper._createInstance();
    }
    return helperdata;
  }

  Future<Database> get database async {
    if (db == null) {
      db = await initialDatabase();
    }
    return db;
  }

  Future<Database> initialDatabase() async {
    Directory dic = await getApplicationDocumentsDirectory();
    String path = dic.path + "task.db";

    var taskDB = await openDatabase(path, version: 1, onCreate: createDatabase);
    return taskDB;
  }

  void createDatabase(Database dbcreate, int versioncreate) async {
    await dbcreate.execute(
        "CREATE TABLE $taskTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $taskName TEXT, $isDone INTEGER)");
  }

  Future<List<Map<String, dynamic>>> getDBMapList() async {
    Database dbMap = await this.database;

    var resault = await dbMap.query(taskTable);
    return resault;
  }

  Future<int> insertTask(Task task) async {
    Database dbInsert = await this.database;
    var resault = await dbInsert.insert(taskTable, task.toMap());
    return resault;
  }

  Future<int> updateTask(Task task) async {
    Database dbUpdate = await this.database;
    var resault = await dbUpdate.update(taskTable, task.toMap(),
        where: "$id = ?", whereArgs: [task.id]);
    return resault;
  }

  Future<int> deleteTask(int iddelete) async {
    var dbDelete = await this.database;
    int resault = await dbDelete
        .rawDelete("DELETE FROM $taskTable WHERE $id = $iddelete");
    return resault;
  }

  Future<List<Task>> getAllTasksList() async {
    var mapListData = await getDBMapList();
    int count = mapListData.length;

    List<Task> tasksgets = new List<Task>();

    for (int i = 0; i <= count - 1; i++) {
      tasksgets.add(Task.fromMapObject(mapListData[i]));
    }
    print('data size : ${tasksgets.length}');
    return tasksgets;
  }

  Future<List<Task>> getTaskListComplete() async {
    var mapListData = await getDBMapList();
    int count = mapListData.length;

    List<Task> tasksget = new List<Task>();

    for (int i = 0; i <= count - 1; i++) {
      tasksget.add(Task.fromMapObject(mapListData[i]));
    }
    print(tasksget.length);
    final data = tasksget.where((element) => element.isDone == 1).toList();
    return data;
  }

  Future<List<Task>> getTaskListInComplete() async {
    var mapListData = await getDBMapList();
    int count = mapListData.length;

    List<Task> tasksget = new List<Task>();

    for (int i = 0; i <= count - 1; i++) {
      tasksget.add(Task.fromMapObject(mapListData[i]));
    }
    print(tasksget.length);
    final data = tasksget.where((element) => element.isDone == 0).toList();
    return data;
  }
}
