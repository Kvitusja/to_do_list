import 'package:flutter/material.dart';

class GroupFormWidget extends StatelessWidget {
  const GroupFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 89, 50, 0.6),
        title: const Text('New group'),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GroupTextField(),
          ),
        ),
      ),
    );
  }
}

class GroupTextField extends StatelessWidget {
  const GroupTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          ListTile(
            title: Text('Add your group name'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(),
          ),
        ],
      ),
    );
  }
}
