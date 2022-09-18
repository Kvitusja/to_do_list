import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/domain/entity/task.dart';
import '../../domain/entity/group.dart';

class TasksWidgetModel extends ChangeNotifier {
  var _tasks = <Task>[];
  List<Task> get tasks => _tasks.toList();

  int groupKey;
  late final Future<Box<Group>> _groupBox;
  Group? _group;
  Group? get group => _group;
  TasksWidgetModel({ required this.groupKey}) {
    _setup();
}

void _loadGroup() async { 
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
}

  void _readTasks(){
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void showTasksForm(BuildContext context) {
    Navigator.of(context).pushNamed('/groups/tasks/taskform', arguments: groupKey);
  }


 void _setupListenTask() async {
    final box = await _groupBox;
    _readTasks();
    box.listenable(keys: <dynamic>[groupKey]).addListener(_readTasks);
 }

  void deleteTask(int groupIndex) {
    _group?.tasks?.deleteFromHive(groupIndex);
  }


  void _setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('group_box');
    _loadGroup();
    _setupListenTask();
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;
  const TasksWidgetModelProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
    key: key,
    child: child,
    notifier: model,
  );

  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TasksWidgetModelProvider oldWidget) {
    return true;
  }
}
