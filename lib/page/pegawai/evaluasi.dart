import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reporting_kinerja_karyawan/utils/itemevaluasi.dart';
import 'package:reporting_kinerja_karyawan/utils/kunci.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Evaluasi extends StatefulWidget {
  Evaluasi({Key? key}) : super(key: key);

  @override
  _EvaluasiState createState() => _EvaluasiState();
}

class _EvaluasiState extends State<Evaluasi> {
  final CollectionReference _evaluasistream = FirebaseFirestore.instance.collection('evaluasi');
  String? lokalId = '';
  void getIdLocal() async {
    SharedPreferences kunciIdLocal = await SharedPreferences.getInstance();
    lokalId = (kunciIdLocal.getString(Kunci.userRandomId));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getIdLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: StreamBuilder<QuerySnapshot>(
        stream: _evaluasistream.where('tujuan', arrayContains: lokalId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error snapshot");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          print(snapshot.data?.docs.map((e) => e.data()));
          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Itemevaluasi(data['evaluasi'], (data['dibuatPada'] as Timestamp).toDate());
          }).toList());
        },
      ),
    );
  }
}
