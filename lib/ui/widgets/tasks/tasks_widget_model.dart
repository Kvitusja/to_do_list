import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/domain/entity/task.dart';
import '../../../domain/entity/group.dart';
import '../../navigation/main_navigation.dart';

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

  void _readTasks() {
    Hive.openBox<Task>('task_box');
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void showTasksForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.taskForm, arguments: groupKey);
  }


 void _setupListenTask() async {
    final box = await _groupBox;
    _readTasks();
    box.listenable(keys: <dynamic>[groupKey]).addListener(_readTasks);
 }

  void deleteTask(int groupIndex) async {
    await Hive.openBox<Task>('task_box');
    await _group?.tasks?.deleteFromHive(groupIndex);
    await _group?.save();
  }

  void doneToggle(int groupIndex) async {
    await Hive.openBox<Task>('task_box');
    final task = group?.tasks?[groupIndex];
    final currentState = task?.isDone ?? false;
    task?.isDone = !currentState;
    await task?.save();
    notifyListeners();
  }

  void _setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('group_box');
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    Hive.openBox<Task>('task_box');
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
