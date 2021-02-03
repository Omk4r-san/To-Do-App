import 'package:ToDoApp/Models/Task_model.dart';
import 'package:ToDoApp/helpers/Database_helpers.dart';
import 'package:ToDoApp/screens/Add-Tasks-Screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Todolistscreen extends StatefulWidget {
  @override
  _TodolistscreenState createState() => _TodolistscreenState();
}

class _TodolistscreenState extends State<Todolistscreen> {
  Future<List<Task>> _tasklist;
  DateFormat _dateFormat = DateFormat("MMM dd, yyyy ");
  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState(() {
      _tasklist = DatabaseHelper.instance.getTaskList();
    });
  }

  Widget _buildTask(Task task) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
              fontSize: 18.0,
              decoration: task.status == 0
                  ? TextDecoration.none
                  : TextDecoration.lineThrough),
        ),
        subtitle: Text(
          "${_dateFormat.format(task.date)}-${task.priority}",
          style: TextStyle(
              fontSize: 15.0,
              decoration: task.status == 0
                  ? TextDecoration.none
                  : TextDecoration.lineThrough),
        ),
        trailing: Checkbox(
          onChanged: (value) {
            task.status = value ? 1 : 0;
          },
          activeColor: Theme.of(context).primaryColor,
          value: true,
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddTaskScreen(
                    updateTaskList: _updateTaskList, task: task))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddTaskScreen())),
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
      body: FutureBuilder(
        future: _tasklist,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
          final int completedtasks = snapshot.data
              .where((Task task) => task.status == 1)
              .toList()
              .length;

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 40),
            itemCount: 1 + snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My tasks",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text("$completedtasks of ${snapshot.data.length}"),
                    ],
                  ),
                );
              }

              return _buildTask(snapshot.data(index - 1));
            },
          );
        },
      ),
    );
  }
}
