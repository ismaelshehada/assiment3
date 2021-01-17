import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:assiment3/TaskModel.dart';
import 'package:assiment3/dataBase/DpHelper.dart';

class AllTasks extends StatefulWidget {
  Task task;
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  DatabaseHelper helperDB = new DatabaseHelper();
  List<Task> taskList;
  int count = 0;
  Task updateTask;
  bool flag = false;
  bool checkChangeValue;

  void updateListV() {
    final Future<Database> dbF = helperDB.initialDatabase();
    dbF.then((valueDB) {
      Future<List<Task>> taskk = helperDB.getAllTasksList();
      taskk.then((valueList) {
        setState(() {
          this.taskList = valueList;
          this.count = valueList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (taskList == null) {
      taskList = new List<Task>();
      updateListV();
    }

    return getAllTasks();
  }

  ListView getAllTasks() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: GestureDetector(
              child: Icon(Icons.delete, color: Colors.black54),
              onTap: () {
                deleteTask(context, this.taskList[position]);
              },
            ),
            trailing: Checkbox(
              value: isDoneValue(
                this.taskList[position].isDone,
              ),
              onChanged: (value) {
                updateTask = taskList[position];
                int changeValue = value == true ? 1 : 0;
                updateTask.isDone = changeValue;
                setState(() {
                  updateT(updateTask);
                });
              },
            ),
            title: Text(this.taskList[position].taskName),
          ),
        );
      },
    );
  }

  bool isDoneValue(int value) {
    switch (value) {
      case 1:
        return true;
        break;
      case 0:
        return false;
        break;
    }
  }

  void deleteTask(BuildContext con, Task tasks) async {
    int resault = await helperDB.deleteTask(tasks.id);
    if (resault != 0) {
      updateListV();
    }
  }

  void updateT(Task task) async {
    int resault;
    resault = await helperDB.updateTask(task);

    if (resault == 0) {
      print("not saved");
    } else {
      print('saved success');
    }
  }
}
