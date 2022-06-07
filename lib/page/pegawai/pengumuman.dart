import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reporting_kinerja_karyawan/utils/itempengumuman.dart';
import 'package:reporting_kinerja_karyawan/utils/gaya.dart';

class Pengumuman extends StatefulWidget {
  Pengumuman({Key? key}) : super(key: key);

  @override
  _PengumumanState createState() => _PengumumanState();
}

class _PengumumanState extends State<Pengumuman> {
  final Stream<QuerySnapshot> _pengumumanStream =
      FirebaseFirestore.instance.collection('pengumuman').orderBy('dibuatPada', descending: true).snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700],
      body: StreamBuilder(
          stream: _pengumumanStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              print(data);
              return ItemPengumuman(data['Pengumuman'], (data['dibuatPada'] as Timestamp).toDate());
            }).toList());
          }),
    );
  }
}
