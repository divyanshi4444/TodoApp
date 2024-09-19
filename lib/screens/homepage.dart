import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/utils/dialog_box.dart';

import '../utils/todo_title.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
//reference the hive box
  final _mybox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    // TODO: implement initState
    //if this 8is first time ever opening the app create default data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there are already data
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

//checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
  }

  void SaveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onCancel: () => Navigator.of(context).pop(),
            onSave: SaveNewTask,
          );
        });
  }

  // void EditTask() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return DialogBox(
  //           controller: _controller,
  //           onCancel: () => Navigator.of(context).pop(),
  //           onSave: SaveNewTask,
  //         );
  //       });
  // }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text(
          'To Do',
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskname: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
    );
  }
}
