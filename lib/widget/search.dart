
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 213, 209, 209),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: const [
          Icon(Icons.search),
          SizedBox(
            width: 10,
          ),
          Text("Cari Judul Diskusi")
        ],
      ),
    );
  }
}
