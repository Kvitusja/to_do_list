import '../widgets/group_form/group_form_widget.dart';
import '../widgets/groups/groups_widget.dart';
import '../widgets/task_form/task_form_widget.dart';
import '../widgets/tasks/tasks_widget.dart';
import 'package:flutter/material.dart';

abstract class MainNavigationRouteNames {
  static const groups = '/';
  static const groupForm = 'groups/form';
  static const tasks = '/groups/tasks';
  static const taskForm = '/groups/tasks/taskform';
  }


  class MainNavigation {
    final initialRoute = MainNavigationRouteNames.groups;
    final routes = {
      MainNavigationRouteNames.groups: (context) => const GroupsWidget(),
      MainNavigationRouteNames.groupForm: (context) => const GroupFormWidget(),
    };

    Route<Object> onGenerateRoute(RouteSettings settings){
        switch(settings.name) {
          case MainNavigationRouteNames.tasks:
           final groupKey = settings.arguments as int;
            return MaterialPageRoute(builder: (context) {
            return TasksWidget(groupKey: groupKey);
          },);
          case MainNavigationRouteNames.taskForm:
            final groupKey = settings.arguments as int;
            return MaterialPageRoute(builder: (context){
            return TaskFormWidget(groupKey: groupKey);
          },);
          default:
            const widget = Text('Navigation error');
            return MaterialPageRoute(builder:
            (context) => widget,
            );
        }
    }
}