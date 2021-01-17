import 'package:assiment3/Tasks/completeTask.dart';
import 'package:assiment3/Tasks/incop.dart';
import 'package:assiment3/pages/N_Task.dart';
import 'package:flutter/material.dart';
import 'package:assiment3/Tasks/AllTask.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: index,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.greenAccent,
            title: Text("Task"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "All Task",
                ),
                Tab(
                  text: "Complete Task   ",
                ),
                Tab(
                  text: "InComplete Task  ",
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            AllTasks(),
            CompleteTasks(),
            InCompleteTasks(),
          ]),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewTask()),
              );
            },
            child: Icon(
              Icons.add,
              size: 28,
            ),
          ),
        ));
  }
}
