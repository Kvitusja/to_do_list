import 'package:hive/hive.dart';
import 'package:to_do_list/domain/entity/group.dart';
import 'package:to_do_list/domain/entity/task.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();
  BoxManager._();

  Future<Box<Group>> openGroupBox() async {
    return _openBox(GroupAdapter(), 'group_box', 1);

}

  Future<Box<Task>> openTaskBox(int groupKey) async {
    return _openBox(TaskAdapter(), makeTaskBoxName(groupKey), 2);

  }

  Future<void> closeBox<T>(Box<T> box) async {
    await box.compact();
    await box.close();
  }

  String makeTaskBoxName(int groupKey) => 'task_box_$groupKey';

  Future<Box<T>> _openBox<T>(
      TypeAdapter<T> adapter,
      String name,
      int typeID
      )
  async {
    if (!Hive.isAdapterRegistered(typeID)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(name);
  }
}
