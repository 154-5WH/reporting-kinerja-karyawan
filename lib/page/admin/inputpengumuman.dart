import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reporting_kinerja_karyawan/utils/gaya.dart';

class Inputpengumuman extends StatelessWidget {
  final TextEditingController pengumumanController = TextEditingController();

  Inputpengumuman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pengumuman = firestore.collection('pengumuman');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber[700],
      body: Column(
        children: [
          SafeArea(
              child: Column(
            children: [
              Text(
                'Input Pengumuman',
                style: GayaText(),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.025,
                  bottom: MediaQuery.of(context).size.height * 0.025,
                ),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.025,
                  bottom: MediaQuery.of(context).size.height * 0.025,
                ),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        maxLines: 25,
                        textInputAction: TextInputAction.newline,
                        controller: pengumumanController,
                        decoration: InputDecoration(
                            hintText: "Masukan Pengumuman",
                            labelText: "Pengumuman",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            pengumuman.add({'pengumuman': pengumumanController.text, 'dibuatPada': DateTime.now()});

                            pengumumanController.text = '';
                          },
                          child: const Text('Input'))
                    ],
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
