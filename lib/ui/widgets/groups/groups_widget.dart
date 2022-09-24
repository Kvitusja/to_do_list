import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list/ui/widgets/groups/groups_widget_model.dart';

class GroupsWidget extends StatefulWidget {
  const GroupsWidget({Key? key}) : super(key: key);

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final _model = GroupsWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(
        model: _model, child: const _GroupWidgetBody());
  }
}

class _GroupWidgetBody extends StatelessWidget {
  const _GroupWidgetBody({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
        title: (const Text('Groups')),
      ),
      body: const SafeArea(
        child: _GroupListWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
        onPressed: () => GroupsWidgetModelProvider.read(context)?.model.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}


class _GroupListWidget extends StatelessWidget {
  const _GroupListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount = GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
        itemCount: groupsCount ,
        separatorBuilder: (BuildContext context, int index) => GroupRowWidget(
          indexInList: index + 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.white10,
          );
        });
  }
}

class GroupRowWidget extends StatelessWidget {
  final int indexInList;
  const GroupRowWidget({Key? key, required this.indexInList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupsWidgetModelProvider.read(context)!.model;
    final group = model.groups[indexInList];
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
            onPressed: (context) => model.deleteGroup(indexInList),
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
          title: Text(group.name, style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),),
          trailing: const Icon(Icons.chevron_right_outlined, color: Colors.white,),
          onTap:() => model.showTasks(context, indexInList),
        ),
      ),
    );
  }
}
