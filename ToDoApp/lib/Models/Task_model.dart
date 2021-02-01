import 'dart:ffi';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';

class Task {
  int id;
  String title;
  DateTime date;
  String priority;
  int status; //0- incomplete 1-complete

  Task({this.title, this.date, this.priority, this.status});
  Task.withid({this.id, this.title, this.date, this.priority, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['date'] = date;
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withid(
      id: map['id'],
      title: map['tit le'],
      date: DateTime.parse(map['date']),
      priority: map['priority'],
      status: map['status'],
    );
  }
}
