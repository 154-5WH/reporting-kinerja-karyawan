import 'package:flutter/material.dart';
import 'package:reporting_kinerja_karyawan/page/admin/admin.dart';
import 'package:reporting_kinerja_karyawan/page/admin/loginadmin.dart';
import 'package:reporting_kinerja_karyawan/page/pegawai/loginpegawai.dart';
import 'package:reporting_kinerja_karyawan/utils/apinyakopid.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  Covid? kopit = null;
  @override
  void initState() {
    super.initState();
    getDataCovid();
  }

  void getDataCovid() async {
    kopit = await Covid.sambungKeApi();
    print('z $kopit');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700],
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
              child: SizedBox(height: MediaQuery.of(context).size.height * 0.3, child: Image.asset("assets/beranda.png")),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Loginadmin()));
                        },
                        child: Text("Admin", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900])),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Color(0xFF4A148C), width: 3), borderRadius: BorderRadius.circular(17))),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Loginpegawai()));
                          },
                          child: Text("Pegawai", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900])),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Color(0xFF4A148C), width: 3), borderRadius: BorderRadius.circular(17))),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                    child: Container(
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
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                            child: Text('Update COVID19', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                          ),
                          Text('Jumlah positif :${kopit?.total['jumlah_positif'].toString() ?? '0'}', style: TextStyle(fontWeight: FontWeight.w700)),
                          Text('Jumlah dirawat :${kopit?.total['jumlah_dirawat'].toString() ?? '0'}', style: TextStyle(fontWeight: FontWeight.w700)),
                          Text('Jumlah sembuh :${kopit?.total['jumlah_sembuh'].toString() ?? '0'}', style: TextStyle(fontWeight: FontWeight.w700)),
                          Text('Jumlah meninggal :${kopit?.total['jumlah_meninggal'].toString() ?? '0'}',
                              style: TextStyle(fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
