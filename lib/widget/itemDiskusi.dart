import 'package:flutter/material.dart';
import 'package:ruang_diskusi/screen/Disscussion.dart';

class ItemDiskusi extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Disscussion();
          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
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
                      const Text(
                        "17 September 2022",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Dok Kepala saya sakit ?",
                          style: TextStyle(fontSize: 30, color: Colors.pink)),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.account_box_rounded),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Budiman")
                                ],
                              )
                            ],
                          ),
                          const Text("#Spesialis-Mata")
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
