import 'package:flutter/material.dart';

class add extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Tambah Diskusi"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text("Pertanyaan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    labelText: 'Pertanyaan'),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(" Masukkan pertanyaan singkat anda"),
              const SizedBox(
                height: 10,
              ),
              const Text("Uraian Pertanyaan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    hintText: "Uraian Pertanyaan"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Kata Kunci",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    hintText: "Kata Kunci"),
              ),
              const Text(
                  "Tuliskan beberapa kata kunci pertanyaan Anda Contoh : Kepala, pundak, lutut, kaki, lutut, kaki."),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      "Buat",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Batal",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
