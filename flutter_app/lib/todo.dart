import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math';
import 'dart:collection';
import 'package:uuid/uuid.dart';

class TodoObject{

  String uuid;
  int sortID;
  String title;
  Color color;
  IconData icon;
  Map<DateTime,List<Task>>
}


class TaskObject{
  DateTime date;
  String task;
  bool _completed;

  TaskObject(this.date, this.task, this._completed){
    this.date = date;
    this.task = task;
    this._completed = _completed;
  }

  TaskObject.import(String task,DateTime date,bool completed){
    this.task = task;
    this.date = date;
    this._completed = completed;
  }

  set completed(bool value) {
    _completed = value;
  }

  isCompleted() => _completed;

}