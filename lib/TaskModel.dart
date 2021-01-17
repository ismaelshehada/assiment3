class Task {
  int id;
  String taskName;
  int isDone = 0;

  Task(this.taskName, this.isDone);

  Task.withId(this.id, this.taskName, this.isDone);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['taskName'] = taskName;
    map['isDone'] = isDone;

    return map;
  }

  Task.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.taskName = map['taskName'];
    this.isDone = map['isDone'];
  }
}
