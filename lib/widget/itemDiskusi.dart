import 'package:flutter/material.dart';
import 'package:ruang_diskusi/models/Discussion.dart';
import 'package:ruang_diskusi/screen/Disscussion.dart';
import 'package:intl/intl.dart';

class ItemDiskusi extends StatefulWidget {
  final DiscussionModel data;

  const ItemDiskusi({
    required this.data,
  });

  @override
  State<ItemDiskusi> createState() => _ItemDiskusiState();
}

class _ItemDiskusiState extends State<ItemDiskusi> {
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Disscussion(
              data: widget.data,
            );
          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(width: 2, color: Colors.black)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   w,
                      //   style: TextStyle(fontSize: 20),
                      // ),
                      // date
                      Text(
                        DateFormat('dd MMMM yyyy')
                            .format(widget.data.created_at.toDate()),
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.data.title.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.pink)),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.account_box_rounded),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(widget.data.user)
                                ],
                              )
                            ],
                          ),
                          Text(
                            "#${widget.data.keyword.toString()}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
