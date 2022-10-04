import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:ruang_diskusi/screen/FirstScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<FirebaseApp>(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return firstScreen();
              // return SettingProfile();
            }
            return const Center(
              // ignore: prefer_const_constructors
              child: CircularProgressIndicator(),
            );
          }),
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
    );
  }
}
