import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ruang_diskusi/models/Comment.dart';

class DetailComment extends StatefulWidget {
  final CommentModel data;
  final String id;
  final String discussion_id;
  final String discussion_user_name;

  const DetailComment({
    Key? key,
    required this.data,
    required this.id,
    required this.discussion_id,
    required this.discussion_user_name,
  }) : super(key: key);

  @override
  State<DetailComment> createState() => _DetailCommentState();
}

class _DetailCommentState extends State<DetailComment> {
  var _userName = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  _initData() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      print('name: ${value.data()!['name']}');
      print('name: 2 ${widget.discussion_user_name}');

      setState(() {
        _userName = value.data()!['name'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('id : ${widget.id}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Detail Komentar"),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.circle),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget.data.user_id.toString()),
                            ],
                          ),
                        ],
                      ),
                      Text(DateFormat('dd MMMM yyyy')
                          .format(widget.data.created_at.toDate()))
                    ],
                  ),
                  Text(widget.data.content.toString())
                ],
              ),
            ),
            // button for the best comment
            if (_userName == widget.discussion_user_name)
              FlatButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('discussions')
                        .doc(widget.discussion_id)
                        .collection('comments')
                        .doc(widget.id)
                        .update({'is_the_best': true});

                    // tambah point
                    FirebaseFirestore.instance
                        .collection('users')
                        .where('name', isEqualTo: widget.data.user_id)
                        .get()
                        .then((value) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(value.docs[0].id)
                          .update({'point': value.docs[0].data()['point'] + 5});
                    });

                    Navigator.pop(context);
                  },
                  color: Colors.green,
                  child: Text('Jadikan Yang Terbaik'))
          ],
        ),
      ),
    );
  }
}
