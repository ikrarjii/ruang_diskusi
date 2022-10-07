import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ruang_diskusi/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/Add_Disscussion.dart';
import '../screen/RankDocter.dart';

class drawer extends StatefulWidget {
  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  var _email = '';
  var _name = '';
  var _image = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  _initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      print(value.data());
      setState(() {
        _email = value.data()!['email'];
        // _email = _email;
        _name = value.data()!['name'];
        _image = value.data()!['image'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_email),
            accountEmail: Text(_name),
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(_image)),
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
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Keluar'),
            onTap: (() async {
              // logout
              FirebaseAuth.instance.signOut();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              prefs.remove('name');
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }),
          ),
        ],
      ),
    );
  }
}
