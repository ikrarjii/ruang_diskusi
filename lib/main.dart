import 'package:flutter/material.dart';

import 'package:ruang_diskusi/screen/FirstScreen.dart';
import 'package:ruang_diskusi/screen/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
    );
  }
}
