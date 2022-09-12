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
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
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
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Add your group name',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              //autofocus: true,
              decoration: InputDecoration(
                hintText: 'Group name',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              backgroundColor: const MaterialStatePropertyAll(Color.fromRGBO(36, 89, 50, 0.6))),
            onPressed: () {},
            child: const Icon(Icons.done_outline, color: Colors.black),
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
