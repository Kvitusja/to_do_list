import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/domain/entity/task.dart';
import 'package:to_do_list/ui/widgets/tasks/tasks_widget.dart';
import '../../../domain/data_provider/box_manager.dart';
import '../../navigation/main_navigation.dart';




class TasksWidgetModel extends ChangeNotifier {
  late final Future<Box<Task>> _box;
  ValueListenable<Object>? _listenableBox;
  TaskWidgetConfiguration configuration;
  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();


  // late final Future<Box<Group>> _groupBox;
  // Group? _group;
  // Group? get group => _group;
  TasksWidgetModel({required this.configuration}) {
    _setup();
  }

  Future<void> _readTasksFromHive() async {
    //Hive.openBox<Task>('task_box');
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  void showTasksForm(BuildContext context) {
    Navigator.of(context).pushNamed(
        MainNavigationRouteNames.taskForm, arguments: configuration.groupKey);
  }

  Future<void> deleteTask(int taskIndex) async {
    await (await _box).deleteAt(taskIndex);

  }

  Future<void> doneToggle(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openTaskBox(configuration.groupKey);
    await _readTasksFromHive();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readTasksFromHive);
  }

  @override
  Future<void> dispose() async{
    _listenableBox?.removeListener(_readTasksFromHive);
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
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
