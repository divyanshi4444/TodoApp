import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'button.dart';

class TodoTile extends StatelessWidget {
  final String taskname;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TodoTile({
    super.key,
    required this.taskname,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SizedBox(
              width: 6,
            ),
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.grey,
                ),
                Text(
                  taskname,
                  style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey[500],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return EditDialog();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class EditDialog extends StatelessWidget {
  final edit;
  final update;
  const EditDialog({super.key, this.edit, this.update});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          children: [
            //get user textfield
            TextField(
              controller: edit,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            //buttons ->save or cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Button(
                  text: 'Save',
                  onPressed: edit,
                ),
                Button(
                  text: 'Cancel',
                  onPressed: update,
                ),
              ],
            )
          ],
        ),
      ),
    );

  }
}