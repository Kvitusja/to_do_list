import 'package:flutter/material.dart';
import 'package:to_do_list/ui/widgets/group_form/group_form_widget_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({Key? key}) : super(key: key);

  @override
  State<GroupFormWidget> createState() => _GroupFormWidgetState();
}

class _GroupFormWidgetState extends State<GroupFormWidget> {
  final _model = GroupFormWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvider(
        model: _model, child: const _GroupFormWidgetBody());
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
        title: const Text('New group'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: GroupTextField(),
        ),
      ),
    );
  }
}

class GroupTextField extends StatelessWidget {
  const GroupTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.read(context)?.model;
    return Card(
      color: const Color.fromRGBO(36, 89, 50, 0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Add your group name',
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.white70,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),
              cursorColor: Colors.white70,
              //autofocus: true,
              decoration: InputDecoration(
                hintText: 'Group name',
                hintStyle:
                    const TextStyle(color: Colors.white70, fontSize: 16.0),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2.0, color: Colors.white70),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2.0, color: Colors.white70),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) => model?.groupName = value,
              onEditingComplete: () => model?.saveGroup(context),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 45,
                height: 45,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
                    onPressed: () => GroupFormWidgetModelProvider.read(context)?.model.saveGroup(context),
                    child: const Icon(Icons.done_outlined, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
