import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list/widgets/tasks/tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TasksWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TasksWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TasksWidgetModelProvider(
      model: _model!,
      child: const TaskWidgetBody(),
    );
  }
}

class TaskWidgetBody extends StatelessWidget {
  const TaskWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    model?.group?.name ?? 'stuff';
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
        title: (const Text('Tasks')),
      ),
      body: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
            onPressed: () => model!.showTasksForm(context),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// class _TaskListWidget extends StatelessWidget {
//   const _TaskListWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final groupsCount = TasksWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
//     return ListView.separated(
//         itemCount: groupsCount ,
//         separatorBuilder: (BuildContext context, int index) => GroupRowWidget(
//           indexInList: index + 1,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return const Divider(
//             color: Colors.white10,
//           );
//         });
//   }
// }
//
// class GroupRowWidget extends StatelessWidget {
//   final int indexInList;
//   const GroupRowWidget({Key? key, required this.indexInList}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final model = TasksWidgetModelProvider.read(context)!.model;
//     final group = model.tasks[indexInList];
//     return Slidable(
//       endActionPane: ActionPane(
//         motion: const DrawerMotion(),
//         children: [
//           SlidableAction(
//             backgroundColor: Colors.red,
//             borderRadius: const BorderRadius.only(
//                 topRight: Radius.circular(16.0),
//                 bottomRight: Radius.circular(16.0)),
//             flex: 4,
//             onPressed: (context) => model.deleteTask(indexInList),
//             icon: Icons.delete,
//           ),
//         ],
//       ),
//       child: Container(
//         margin: const EdgeInsets.only(left: 8.0),
//         height: 120,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(16.0),
//               bottomLeft: Radius.circular(16.0)),
//           color: Color.fromRGBO(36, 89, 50, 0.6),
//         ),
//         child: ListTile(
//           title: Text(),
//           trailing: const Icon(Icons.chevron_right_outlined),
//           onTap:() => model.showTasks(context, indexInList),
//         ),
//       ),
//     );
//   }
// }