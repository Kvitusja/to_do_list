import 'package:flutter/material.dart';
import 'groups/groups_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/groups': (context) => const GroupsWidget(),
      },
      initialRoute: '/groups',
    );
  }
}
