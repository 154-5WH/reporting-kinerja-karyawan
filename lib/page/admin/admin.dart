import 'package:flutter/material.dart';
import 'package:reporting_kinerja_karyawan/page/admin/inputevaluasi.dart';
import 'package:reporting_kinerja_karyawan/page/admin/inputpengumuman.dart';
import 'package:reporting_kinerja_karyawan/page/admin/jamkerja.dart';
import 'package:reporting_kinerja_karyawan/page/admin/pegawaibaru.dart';

class Admin extends StatelessWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Pegawaibaru()));
                    },
                    child: Text(
                      "Pegawai Baru",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900]),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFF4A148C), width: 3), borderRadius: BorderRadius.circular(17))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const InputEvaluasi()));
                      },
                      child: Text(
                        "Evaluasi",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900]),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF4A148C), width: 3), borderRadius: BorderRadius.circular(17))),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Inputpengumuman()));
                      },
                      child: Text(
                        "Pengumuman",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900]),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF4A148C), width: 3), borderRadius: BorderRadius.circular(17))),
                    )),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Jamkerja()));
                    },
                    child: Text(
                      "Jam Kerja",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900]),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFF4A148C), width: 3), borderRadius: BorderRadius.circular(17))),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
