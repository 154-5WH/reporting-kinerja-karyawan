import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reporting_kinerja_karyawan/utils/gaya.dart';

class Pegawaibaru extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController ponselController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber[700],
      body: Column(
        children: [
          SafeArea(
              child: (Column(
            children: [
              Text(
                "Input Data Karawan",
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
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        // left: MediaQuery.of(context).size.width * 0.05,
                        // right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.025,
                        bottom: MediaQuery.of(context).size.height * 0.025,
                      ),
                      child: TextFormField(
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                        textInputAction: TextInputAction.next,
                        controller: namaController,
                        decoration: InputDecoration(
                            hintText: "Masukan Nama Pegawai",
                            labelText: "Nama Pegawai",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        // left: MediaQuery.of(context).size.width * 0.05,
                        // right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.025,
                        bottom: MediaQuery.of(context).size.height * 0.025,
                      ),
                      child: TextFormField(
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                        textInputAction: TextInputAction.next,
                        controller: idController,
                        decoration: InputDecoration(
                            hintText: "Masukan ID Pegawai",
                            labelText: "ID Pegawai",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        // left: MediaQuery.of(context).size.width * 0.05,
                        // right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.025,
                        bottom: MediaQuery.of(context).size.height * 0.025,
                      ),
                      child: TextFormField(
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                        textInputAction: TextInputAction.next,
                        controller: ponselController,
                        decoration: InputDecoration(
                            hintText: "Masukan Ponsel Pegawai",
                            labelText: "Ponsel Pegawai",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        // left: MediaQuery.of(context).size.width * 0.05,
                        // right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.025,
                        bottom: MediaQuery.of(context).size.height * 0.025,
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.send,
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: "Masukan Password Pegawai",
                            labelText: "Password Pegawai",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          users.add({
                            'name': namaController.text,
                            'ID': int.tryParse(idController.text) ?? 0,
                            'Ponsel': int.tryParse(ponselController.text) ?? 0,
                            'password': passwordController.text,
                          });
                          namaController.text = '';
                          idController.text = '';
                          ponselController.text = '';
                          passwordController.text = '';
                        },
                        child: Text('input'))
                  ],
                ),
              )
            ],
          ))),
        ],
      ),
    );
  }
}
