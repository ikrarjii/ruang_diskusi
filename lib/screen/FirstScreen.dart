import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ruang_diskusi/models/Discussion.dart';
import 'package:ruang_diskusi/screen/login.dart';
import 'package:ruang_diskusi/widget/drawer.dart';
import 'package:ruang_diskusi/widget/itemDiskusi.dart';
import 'package:ruang_diskusi/widget/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class firstScreen extends StatefulWidget {
  @override
  State<firstScreen> createState() => _firstScreenState();
}

class _firstScreenState extends State<firstScreen> {
  var _name = '';
  var _search = '';
  void initState() {
    super.initState();
    _initData();
    _checkSession();
  }

  _initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      prefs.setString('name', value.data()!['name']);
      setState(() {
        _name = value.data()!['name'];
      });
    });
  }

  _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    // print('email : $email');
    if (email == '' || email == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hi, $_name",
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      // margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: TextField(
                        // control
                        onSubmitted: (value) {
                          setState(() {
                            // _search = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _search = value;
                          });
                        },
                        style:
                            const TextStyle(height: 0.8, color: Colors.black),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Mencari...',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: StreamBuilder<QuerySnapshot<DiscussionModel>>(
                stream: FirebaseFirestore.instance
                    .collection('discussions')
                    .orderBy('created_at', descending: true)
                    .withConverter<DiscussionModel>(
                        fromFirestore: (snapshots, _) =>
                            DiscussionModel.fromJson(snapshots.data()),
                        toFirestore: (discussion, _) => discussion.toJson())
                    .snapshots(),
                // .map((event) => event.docs
                //     .map((e) => DiscussionModel.fromJson(e.data()))
                //     .toList()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // return Text('oke');
                  return ListView(
                      children: snapshot.data!.docs
                          .where((element) => element
                              .data()
                              .title
                              .toLowerCase()
                              .contains(_search.toLowerCase()))
                          .map((e) => ItemDiskusi(
                                data: e.data(),
                              ))
                          .toList());
                }),
          )
        ],
      ),
      drawer: drawer(),
    );
  }
}
