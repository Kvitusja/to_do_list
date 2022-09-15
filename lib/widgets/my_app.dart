import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/group_form/group_form_widget.dart';
import 'package:to_do_list/widgets/task_form/task_form_widget.dart';
import 'package:to_do_list/widgets/tasks/tasks_widget.dart';
import 'groups/groups_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/groups': (context) => const GroupsWidget(),
        '/groups/form': (context) => const GroupFormWidget(),
        '/groups/tasks': (context) => const TasksWidget(),
        '/groups/tasks/taskform': (context) => const TaskFromWidget(),
      },
      initialRoute: '/groups',
    );
  }
}
