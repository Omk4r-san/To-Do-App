import 'package:ToDoApp/screens/Add-Tasks-Screen.dart';
import 'package:flutter/material.dart';

class Todolistscreen extends StatefulWidget {
  @override
  _TodolistscreenState createState() => _TodolistscreenState();
}

class _TodolistscreenState extends State<Todolistscreen> {
  Widget _buildTask(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        title: Text("Task Title"),
        subtitle: Text("jan 29, 2021 - High"),
        trailing: Checkbox(
          onChanged: (value) {
            print(value);
          },
          activeColor: Theme.of(context).primaryColor,
          value: true,
        ),
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
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 40),
        itemCount: 10,
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
                  Text("1 of 10"),
                ],
              ),
            );
          }
          return _buildTask(index);
        },
      ),
    );
  }
}
