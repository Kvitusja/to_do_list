import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/domain/entity/task.dart';
import '../../domain/entity/group.dart';

class TaskFormWidgetModel {
  int groupKey;
  var taskText = "";

  TaskFormWidgetModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    if(taskText.isEmpty) return;

    if (!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }

    if (!Hive.isAdapterRegistered(2)){
      Hive.registerAdapter(TaskAdapter());
    }

    final taskBox = await Hive.openBox<Task>('task_box');
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);


    final groupBox = await Hive.openBox<Group>('group_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);
    //await groupBox.add(group!);


    // final box = await Hive.openBox<Task>('task_box');
    // final task = Task(text: taskText, isDone: null);
    // await box.add(task);
    Navigator.of(context).pop();
  }
}

class TaskFormWidgetModelProvider extends InheritedWidget {
  final TaskFormWidgetModel model;
  const TaskFormWidgetModelProvider({Key? key, required Widget child, required this.model,}) : super (key: key, child: child,);


  static TaskFormWidgetModelProvider ? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvider>();
  }

  static TaskFormWidgetModelProvider ? read(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<TaskFormWidgetModelProvider>()?.widget;
    return widget is TaskFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormWidgetModelProvider oldWidget) {
    return false;
  }}