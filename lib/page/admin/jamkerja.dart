import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Jamkerja extends StatefulWidget {
  Jamkerja({Key? key}) : super(key: key);

  @override
  _JamkerjaState createState() => _JamkerjaState();
}

class _JamkerjaState extends State<Jamkerja> {
  final _jamkerjaViewStream = FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _jamkerjaViewStream,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final dataUserJamKerja = snapshot.data!.docs;
            return ListView.builder(
              itemCount: dataUserJamKerja.length,
              itemBuilder: (context, index) {
                final namaUser = dataUserJamKerja.elementAt(index);

                return GestureDetector(
                    onTap: () {
                      FirebaseFirestore.instance.collection('users').doc(namaUser.id).collection('waktu').snapshots();
                      tampilBottomSheet(context,
                          data: FirebaseFirestore.instance.collection('users').doc(namaUser.id).collection('waktu').snapshots());
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(namaUser.data()['name'], style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
                        ],
                      ),
                    ));
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  void tampilBottomSheet(BuildContext context, {required Stream<QuerySnapshot<Map<String, dynamic>>> data}) {
    String formatedTime(int secTime) {
      String getParsedTime(String time) {
        if (time.length <= 1) return "0$time";
        return time;
      }

      int min = secTime ~/ 60;
      int sec = secTime % 60;

      String parsedTime = getParsedTime(min.toString()) + " : " + getParsedTime(sec.toString());

      return parsedTime;
    }

    String waktuTotalKerja = '';
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
            stream: data,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print(snapshot.data?.docs.map((e) => e.data()));
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  color: Colors.amber,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;

                                return Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('${data['waktuTotal']}', style: TextStyle(color: Colors.black)),
                                      ],
                                    ));
                              }),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Waktu total : ', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
                              Text(
                                  formatedTime(snapshot.data!.docs.fold<int>(0, (previousValue, element) {
                                    final time = element['waktuTotal'].toString().split(':');
                                    final jam = int.tryParse(time.elementAt(0))! * 3600;
                                    final menit = int.tryParse(time.elementAt(1))! * 60;
                                    final detik = int.tryParse(time.elementAt(2))! * 1;
                                    return previousValue + jam + menit + detik;
                                  })),
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          child: const Text('Tutup'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ),
                );
              }
              return CircularProgressIndicator();
            });
      },
    );
  }
}
