import 'package:flutter/material.dart';
import 'package:mydespenseapp/despense/presentation/screens/home_screen.dart';
import 'package:mydespenseapp/providers/sqlite_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DespenseDatabase.instance.createDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomeScreen(),
    );
  }
}
