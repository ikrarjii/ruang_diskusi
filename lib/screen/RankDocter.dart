import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ruang_diskusi/models/User.dart';

class Rank extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Rangking Dokter"),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Rangking Dokter",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot<UserModel>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('role', isEqualTo: 'dokter')
                      .withConverter<UserModel>(
                          fromFirestore: (snapshots, _) =>
                              UserModel.fromJson(snapshots.data()),
                          toFirestore: (user, _) => user.toJson())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children: [
                        for (var i = 0; i < snapshot.data!.docs.length; i++)
                          Card(
                            color: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              "#Rangking ${i + 1} ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(snapshot
                                                    .data!.docs[i]
                                                    .data()
                                                    .image))),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          "${snapshot.data!.docs[i].data().name}"),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(snapshot.data!.docs[i]
                                          .data()
                                          .spesialis),
                                      Text(snapshot.data!.docs[i].data().RS),
                                      Text(
                                          "${snapshot.data!.docs[i].data().point} Point"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
