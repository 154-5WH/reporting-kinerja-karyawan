import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reporting_kinerja_karyawan/utils/kunci.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reporting_kinerja_karyawan/page/pegawai/pegawai.dart';

class Loginpegawai extends StatefulWidget {
  const Loginpegawai({Key? key}) : super(key: key);

  @override
  _LoginpegawaiState createState() => _LoginpegawaiState();
}

class _LoginpegawaiState extends State<Loginpegawai> {
  // String salah = '';
  void loginPegawai() async {
    final pegawai = await FirebaseFirestore.instance.collection('users').get();
    final validasiDatanyaFirebase = pegawai.docs
        .where((data) =>
            (usernamePegawaiController.text == data.data()['Ponsel'].toString() || usernamePegawaiController.text == data.data()['ID'].toString()))
        .toList();
    if (validasiDatanyaFirebase.isNotEmpty) {
      if (passwordPegawaiController.text == validasiDatanyaFirebase.first.data()['password']) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString(Kunci.userRandomId, validasiDatanyaFirebase.first.id);
        print('benar');
        // salah = '';
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pegawai()));
        // ini untuk navigator
        setState(() {});
        // break;
      }
    } else {
      const snackBar = SnackBar(
        content: Text('masukan username dan passowrd yang benar'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {});
      print('salah');
    }
  }

  final TextEditingController usernamePegawaiController = TextEditingController();
  final TextEditingController passwordPegawaiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber[700],
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
              child: SizedBox(height: MediaQuery.of(context).size.height * 0.3, child: Image.asset("assets/admin.png")),
            ),
            Text("Login sebagai pegawai", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900])),
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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.025,
                      bottom: MediaQuery.of(context).size.height * 0.025,
                    ),
                    child: TextFormField(
                      controller: usernamePegawaiController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "masukan ID pegawai",
                          labelText: "ID Pegawai",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.025,
                      bottom: MediaQuery.of(context).size.height * 0.025,
                    ),
                    child: TextFormField(
                      controller: passwordPegawaiController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "masukan Password", labelText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      loginPegawai();
                    },
                    child: Text("masuk", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900])),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFF4A148C), width: 3), borderRadius: BorderRadius.circular(17))),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
