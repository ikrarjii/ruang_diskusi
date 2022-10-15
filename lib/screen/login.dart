import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ruang_diskusi/screen/FirstScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _email = '';
  var _password = '';
  var _error = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkSession();
  }

  _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    if (email != '') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => firstScreen()));
    }
  }

  bool obscureText = true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _error ?? '',
              style: const TextStyle(color: Colors.red),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
                focusedBorder: OutlineInputBorder(),
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: 'Password Mobile Jkn',
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
                isDense: true,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              onPressed: () async {
                // FirebaseAuth.instance
                //     .signInWithEmailAndPassword(
                //         email: _email, password: _password)
                //     .then((value) async {
                //   SharedPreferences prefs =
                //       await SharedPreferences.getInstance();
                //   prefs.setString('name', _email);
                //   Navigator.pushReplacement(context,
                //       MaterialPageRoute(builder: (context) => firstScreen()));
                // });
                var result =
                    await signInWithEmail(email: _email, pass: _password);
                if (result != null) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('email', _email);
                  prefs.setString('email', result.uid);
                  // prefs.setString('uid', result.);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => firstScreen()),
                  );
                } else {
                  setState(() {
                    _error = 'Email atau Password Salah';
                  });
                }
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return firstScreen();
                // }));
              },
              child: const Text(
                'Masuk',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future signInWithEmail(
      {required String email, required String pass}) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      return result.user;
    } catch (e) {
      return null;
    }
  }
}
