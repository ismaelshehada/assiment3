import 'package:assiment3/TaskModel.dart';
import 'package:assiment3/dataBase/DpHelper.dart';
import 'package:assiment3/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  DatabaseHelper helperDB = DatabaseHelper();
  String appBarName;
  Task taskk;

  TextEditingController taskNameContr = TextEditingController();
  bool isDoneValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: taskNameContr,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Task Name'),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isDoneValue,
                      onChanged: (newValue) {
                        setState(() {
                          isDoneValue = newValue;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                RaisedButton(
                    textColor: Colors.white,
                    padding: EdgeInsets.all(0.0),
                    shape: StadiumBorder(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff606060),
                            Color(0xff131313),
                          ],
                        ),
                      ),
                      child: Text(
                        'Add New Task',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 20.0),
                    ),
                    onPressed: () {
                      setState(() {
                        saveTask(
                            taskNameContr.text, isDoneValue == true ? 1 : 0);
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveTask(String taskNamee, int doneVale) async {
    int result;
    result = await helperDB.insertTask(Task(taskNamee, doneVale));

    if (result == 0) {
      Navigator.pop(context);
    } else {
      setState(() {});
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }
}
