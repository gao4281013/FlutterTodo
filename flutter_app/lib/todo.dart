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
  Map<DateTime,List<TaskObject>> tasks;


  TodoObject(this.title, this.icon){
    this.title = title;
    this.icon = icon;
    this.color = ColorChoies.colors[new Random().nextInt(ColorChoies.colors.length)];
    tasks = new Map<DateTime,List<TaskObject>>();
    this.uuid = new Uuid().v1();

  }

  TodoObject.import( String uuid, int sortID, String title, Color color, IconData icon, Map<DateTime,List<TaskObject>> tasks){
    this.uuid = uuid;
    this.sortID = sortID;
    this.title = title;
    this.color = color;
    this.icon = icon;
    this.tasks = tasks;
  }

  int taskAmount(){
    int amount = 0;
    tasks.values.forEach((list){
      amount += list.length;
    });
    return amount;
  }

  double percentComplete(){
    if(tasks.isEmpty){
       return 1.0;
    }else{
      int completed = 0;
      int amount = 0;
      tasks.values.forEach((list){
        amount += list.length;
        list.forEach((task){
          if(task.isCompleted()){
            completed++;
          }
        });
      });
      return completed/amount;
    }
  }

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