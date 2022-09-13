import 'package:flutter/material.dart';
import 'package:to_do_list/domain/entity/group.dart';
import 'package:to_do_list/widgets/my_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
WidgetsFlutterBinding.ensureInitialized();
  const app = MyApp();
  runApp(app);
}
