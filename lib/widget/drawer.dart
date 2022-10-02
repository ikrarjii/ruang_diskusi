import 'package:flutter/material.dart';
import '../screen/Add_Disscussion.dart';
import '../screen/RankDocter.dart';

class drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("IKRAR RESTU GIBRANI"),
            accountEmail: Text("ikrar1469@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Tambah Diskusi'),
            onTap: (() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return add();
              }));
            }),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Rangking Dokter'),
            onTap: (() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Rank();
              }));
            }),
          ),
        ],
      ),
    );
  }
}
