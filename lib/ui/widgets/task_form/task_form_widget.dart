import 'package:flutter/material.dart';
import 'package:to_do_list/ui/widgets/task_form/task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  final int groupKey;
  const TaskFormWidget({Key? key, required this.groupKey}) : super(key: key);

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  late final TaskFormWidgetModel _model;

  @override
  void initState() {
    super.initState();
    widget.groupKey;
    _model = TaskFormWidgetModel(groupKey: widget.groupKey);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //
  //   if (_model == null) {
  //     final groupKey = ModalRoute.of(context)!.settings.arguments as int;
  //     _model = TaskFormWidgetModel(groupKey: groupKey);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(
      model: _model,
      child: const _TaskFormWidgetBody(),
    );
  }
}

class _TaskFormWidgetBody extends StatelessWidget {
  const _TaskFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
        onPressed: () =>
            TaskFormWidgetModelProvider.read(context)?.model.saveTask(context),
        child: const Icon(Icons.done_outlined, color: Colors.white),
      ),
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
        title: const Text('New task'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TaskTextField(),
        ),
      ),
    );
  }
}

class TaskTextField extends StatelessWidget {
  const TaskTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.read(context)?.model;
    return TextField(
      style: const TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),
      maxLines: null,
      minLines: null,
      expands: true,
      cursorColor: Colors.white70,
      //autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Task text',
        hintStyle: TextStyle(color: Colors.white70, fontSize: 16.0),
        border: InputBorder.none,
      ),
      onChanged: (value) => model?.taskText = value,
      onEditingComplete: () => model?.saveTask(context),
    );
  }
}
