// ignore: file_names
// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ruang_diskusi/screen/FirstScreen.dart';
import 'package:uuid/uuid.dart';

class add extends StatefulWidget {
  @override
  State<add> createState() => _addState();
}

// ignore: camel_case_types
class _addState extends State<add> {
  // ignore: unused_field
  var _title = '';
  // ignore: unused_field
  var _description = '';
  // ignore: unused_field
  var _keyword = '';
  // ignore: unused_field
  var _user = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  _initData() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) => {
              setState(() {
                _user = value.data()!['name'];
              })
            });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Tambah Diskusi"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text("Pertanyaan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    labelText: 'Pertanyaan'),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(" Masukkan pertanyaan singkat anda"),
              const SizedBox(
                height: 10,
              ),
              const Text("Uraian Pertanyaan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 5,
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    hintText: "Uraian Pertanyaan"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Kata Kunci",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _keyword = value;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    hintText: "Kata Kunci"),
              ),
              const Text(
                  "Tuliskan beberapa kata kunci pertanyaan Anda Contoh : Kepala, pundak, lutut, kaki, lutut, kaki."),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // random uid with uuid
                      var uuid = Uuid().v4();
                      FirebaseFirestore.instance
                          .collection('discussions')
                          .doc(uuid)
                          .set({
                        'id': uuid,
                        'title': _title,
                        'description': _description,
                        'keyword': _keyword,
                        'created_at': DateTime.now(),
                        'user': _user
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => firstScreen()));
                    },
                    child: const Text(
                      "Buat",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Batal",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
