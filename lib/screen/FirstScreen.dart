import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ruang_diskusi/models/Discussion.dart';

import 'package:ruang_diskusi/widget/drawer.dart';
import 'package:ruang_diskusi/widget/itemDiskusi.dart';
import 'package:ruang_diskusi/widget/search.dart';

class firstScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Hi, Madhan",
                            style: TextStyle(fontSize: 24),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 213, 209, 209),
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(Icons.notifications)),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Search(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: StreamBuilder<QuerySnapshot<DiscussionModel>>(
                stream: FirebaseFirestore.instance
                    .collection('discussions')
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
                  return Column(
                      children: snapshot.data!.docs
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
