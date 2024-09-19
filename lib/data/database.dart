import 'package:hive/hive.dart';

class TodoDatabase {
  List toDoList = [];

  //reference our box
  final _mybox = Hive.box('mybox');

//run this method if this the first time opening this app
  void createInitialData() {
    toDoList = [
      ["enter data", false],
      ["notification", false],
    ];
  }

  //load the data from database
  void loadData() {
    toDoList = _mybox.get("TODOLIST");
  }

//update the data  database
  void updateDatabase() {
    _mybox.put("TODOLIST", toDoList);
  }
  void editDatabase(){

  }
}
