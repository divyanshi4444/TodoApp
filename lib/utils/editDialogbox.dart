
import 'package:flutter/material.dart';

class EditDialog extends StatefulWidget {

  final controller;

  VoidCallback onCancel;

   EditDialog({super.key, required this.controller, required this.onCancel});

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = TextEditingController(text: widget.taskname);
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Edit task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle save action
                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle cancel action
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
