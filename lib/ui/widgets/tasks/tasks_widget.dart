import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list/ui/widgets/tasks/tasks_widget_model.dart';

class TaskWidgetConfiguration {
  final int groupKey;

  TaskWidgetConfiguration(this.groupKey);
}


class TasksWidget extends StatefulWidget {
  final TaskWidgetConfiguration configuration;
  const TasksWidget({Key? key, required this.configuration}) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late final TasksWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TasksWidgetModel(configuration: widget.configuration);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //
  //   if (_model == null) {
  //     final groupKey = ModalRoute.of(context)!.settings.arguments as int;
  //     _model = TasksWidgetModel(groupKey: groupKey);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return TasksWidgetModelProvider(
      model: _model,
      child: const TaskWidgetBody(),
    );
  }

  @override
  void dispose() async{
    super.dispose();
    await _model.dispose();

  }
}




class TaskWidgetBody extends StatelessWidget {
  const TaskWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
        onPressed: () => model!.showTasksForm(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
        title: (const Text('Tasks')),
      ),
      body: const _TaskListWidget(),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        TasksWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
        padding: const EdgeInsets.only(top: 15),
        itemCount: groupsCount,
        separatorBuilder: (BuildContext context, int index) =>  const Divider(
          color: Colors.white10,
        ),

        itemBuilder: (BuildContext context, int index) {
          return TaskListRowWidget(
            indexInList: index,
          );
        });
  }
}

class TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  const TaskListRowWidget({Key? key, required this.indexInList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.read(context)!.model;
    final task = model.tasks[indexInList];
    final icon = task.isDone
        ? const Icon(Icons.check_box_outlined, color: Colors.white,)
        : const Icon(Icons.check_box_outline_blank, color: Colors.white,);
    final style = task.isDone
        ? const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.white)
        : const TextStyle(color: Colors.white);

    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0)),
            flex: 4,
            onPressed: (context) => model.deleteTask(indexInList),
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 8.0),
        height: 70,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0)),
          color: Color.fromRGBO(36, 89, 50, 0.6),
        ),
        child: ListTile(
          title: Text(
            task.text,
            style: style,
          ),
          trailing: icon,
          onTap: () => model.doneToggle(indexInList),
        ),
      ),
    );
  }
}
