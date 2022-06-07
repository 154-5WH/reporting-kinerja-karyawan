import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reporting_kinerja_karyawan/page/beranda.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const Beranda();
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
