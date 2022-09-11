import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroupsWidget extends StatelessWidget {
  const GroupsWidget({Key? key}) : super(key: key);

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/groups/form');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
        title: (const Text('Groups')),
      ),
      body: const SafeArea(
        child: GroupListWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
        onPressed: () => showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class GroupListWidget extends StatefulWidget {
  const GroupListWidget({Key? key}) : super(key: key);

  @override
  State<GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<GroupListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 100,
        separatorBuilder: (BuildContext context, int index) => GroupRowWidget(
              indexInList: index,
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
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
            flex: 4,
            onPressed: (context) {},
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(left: 8.0),
        height: 120,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0)),
          color: Color.fromRGBO(36, 89, 50, 0.6),
        ),
        child: ListTile(
          trailing: Icon(Icons.chevron_right_outlined),
          onTap: (){},
        ),
      ),
    );
  }
}
