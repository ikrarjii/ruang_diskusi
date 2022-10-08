import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ruang_diskusi/models/Comment.dart';
import 'package:ruang_diskusi/models/Discussion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Disscussion extends StatefulWidget {
  final DiscussionModel data;
  Disscussion({required this.data});
  @override
  State<Disscussion> createState() => _DisscussionState();
}

class _DisscussionState extends State<Disscussion> {
  var _content = "";
  var _comments = [];

  TextEditingController _controller = TextEditingController();

  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    FirebaseFirestore.instance
        .collection('discussions')
        .doc(widget.data.id)
        .collection('comments')
        .get()
        .then((value) {
      setState(() {
        _comments = value.docs;
      });
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
          title: const Text("Diskusi"),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: StreamBuilder<DocumentSnapshot<DiscussionModel>>(
            stream: FirebaseFirestore.instance
                .collection('discussions')
                .doc(widget.data.id)
                .withConverter<DiscussionModel>(
                    fromFirestore: (snapshots, _) =>
                        DiscussionModel.fromJson(snapshots.data()),
                    toFirestore: (discussion, _) => discussion.toJson())
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.title,
                          style: TextStyle(fontSize: 20, color: Colors.pink),
                          maxLines: 5,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.people),
                                SizedBox(width: 5),
                                Text(widget.data.user)
                              ],
                            )
                          ],
                        ),
                        Text("#${widget.data.keyword}"),
                        Text(DateFormat('dd MMMM yyyy')
                            .format(widget.data.created_at.toDate()))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.comment),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${_comments.length} Pembahasan",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<QuerySnapshot<CommentModel>>(
                        stream: FirebaseFirestore.instance
                            .collection('discussions')
                            .doc(widget.data.id)
                            .collection('comments')
                            .withConverter<CommentModel>(
                                fromFirestore: (snapshots, _) =>
                                    CommentModel.fromJson(snapshots.data()),
                                toFirestore: (comment, _) => comment.toJson())
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Column(
                            children: [
                              for (var i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.circle),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(snapshot.data!.docs[i]
                                                    .data()
                                                    .user_id
                                                    .toString()),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(DateFormat('dd MMMM yyyy').format(
                                            snapshot.data!.docs[i]
                                                .data()
                                                .created_at
                                                .toDate()))
                                      ],
                                    ),
                                    Text(snapshot.data!.docs[i]
                                        .data()
                                        .content
                                        .toString())
                                  ],
                                ),
                            ],
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _controller,
                      maxLines: 6,
                      onChanged: (value) {
                        _content = value;
                        // _controller.text = value;
                        // setState(() {
                        //   _content = value;
                        // });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () async {
                              // random id with uuid
                              var uuid = Uuid().v4();
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              FirebaseFirestore.instance
                                  .collection('discussions')
                                  .doc(widget.data.id)
                                  .collection('comments')
                                  .add({
                                'user_id': prefs.getString('name') ?? '',
                                'content': _content,
                                'created_at': DateTime.now(),
                              });
                              _controller.clear();
                              setState(() {
                                _content = "";
                              });
                            },
                            child: const Text(
                              "Kirim",
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
