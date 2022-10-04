import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ruang_diskusi/models/Discussion.dart';

class Disscussion extends StatelessWidget {
  List<DiscussionModel> discussion = [];

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
        body: StreamBuilder<QuerySnapshot<DiscussionModel>>(
            stream: FirebaseFirestore.instance
                .collection('discussion')
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
              return Column(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                return Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            '',
                            style: TextStyle(fontSize: 20, color: Colors.pink),
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
                                children: const [
                                  Icon(Icons.people),
                                  SizedBox(width: 5),
                                  Text("Budiman")
                                ],
                              )
                            ],
                          ),
                          const Text("#Spesialis-Mata"),
                          const Text("17 Maret 2020")
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: const [
                          Text(
                            "Selamat Malam dok, saya mau bertanya, saya kan lagi main rebahan sambil main  hp, tiba - tiba kepala saya sakit sekali. Itu kenapa yah dok ?",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            maxLines: 5,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.comment),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "4 Pembahasan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
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
                                children: const [
                                  Icon(Icons.circle),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("dr.Rahmat"),
                                ],
                              ),
                            ],
                          ),
                          const Text("1 Hari yang lalu")
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TextField(
                        maxLines: 6,
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
                              onPressed: () {},
                              child: const Text(
                                "Balas",
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      )
                    ],
                  ),
                );
              }).toList());
            }),
      ),
    );
  }
}
