import 'package:flutter/material.dart';

class GroupsWidgetModel extends ChangeNotifier {

}

class GroupsWidgetModelProvider extends InheritedNotifier{
  final GroupsWidgetModel model;
  const GroupsWidgetModelProvider
      ({Key? key, required this.model, required Widget child,}) : super (key: key, notifier: model, child: child,);


  static GroupsWidgetModelProvider ? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupsWidgetModelProvider>();
  }

  static GroupsWidgetModelProvider ? read(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<GroupsWidgetModelProvider>()?.widget;
    return widget is GroupsWidgetModelProvider ? widget : null;
  }
}