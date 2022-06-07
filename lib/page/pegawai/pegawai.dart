import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reporting_kinerja_karyawan/page/pegawai/evaluasi.dart';
import 'package:reporting_kinerja_karyawan/page/pegawai/pengumuman.dart';
import 'package:reporting_kinerja_karyawan/utils/kunci.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pegawai extends StatefulWidget {
  const Pegawai({Key? key}) : super(key: key);

  @override
  State<Pegawai> createState() => _PegawaiState();
}

class _PegawaiState extends State<Pegawai> {
  static const countdownDuration = Duration(hours: 24);
  Duration duration = const Duration();
  Timer? timer;
  bool isCountdown = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void reset() {
    if (isCountdown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void addTime() {
    final addSecond = isCountdown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSecond;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) async {
    if (resets) {
      reset();
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? ambilId = pref.getString(Kunci.userRandomId);

    CollectionReference users = firestore.collection('users');
    CollectionReference waktu = users.doc(ambilId).collection('waktu');

    final getIdWaktu = await waktu.add({"tanggalWaktu": DateTime.now(), "waktuTotal": ""});

    // pengumuman.doc().collection('waktu').add({
    //     "tanggalWaktu":DateTime.now(),
    //     "waktuTotal": "1jam"
    //   });
    // var coba = [
    //   {
    //     "tanggalWaktu":DateTime.now(),
    //     "waktuTotal": "1jam"
    //   }
    // ]

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      addTime();
      String duaDigit(int n) => n.toString().padLeft(2, '0');
      final hours = duaDigit(duration.inHours.remainder(24));
      final minutes = duaDigit(duration.inMinutes.remainder(60));
      final seconds = duaDigit(duration.inSeconds.remainder(60));
      waktu.doc(getIdWaktu.id).update({"waktuBerakhir": DateTime.now(), "waktuTotal": "$hours:$minutes:$seconds"});
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[600],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                  child: Waktu(duration: duration),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Pengumuman()));
                        },
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Pengumuman",
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
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Evaluasi()));
                        },
                        icon: const Icon(Icons.notifications, color: Colors.black),
                        label: Text(
                          "Evaluasi Kinerja",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900]),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xFF4A148C), width: 3), borderRadius: BorderRadius.circular(17))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                    child: buildButtons(),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: stopTimer,
                  child: Text(
                    'Stop Timer',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900]),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(color: Color(0xFF4A148C), width: 3), borderRadius: BorderRadius.circular(17))),

                  // if (isRunning) {
                  //   stopTimer(resets: false);
                  // }
                  // child: Text(isRunning ? 'STOP' : 'RESUME'),
                ),
              ),
              // SizedBox(
              //   width: 20,
              // ),
              // ElevatedButton(onPressed: stopTimer, child: Text('CANCEL'))
            ],
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.6,
            child: ElevatedButton(
              onPressed: () {
                startTimer();
              },
              child: Text(
                'Start Timer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900]),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(side: BorderSide(color: Color(0xFF4A148C), width: 3), borderRadius: BorderRadius.circular(17))),
            ),
          );
  }
}

class Waktu extends StatelessWidget {
  const Waktu({
    Key? key,
    required this.duration,
  }) : super(key: key);

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    String duaDigit(int n) => n.toString().padLeft(2, '0');
    final hours = duaDigit(duration.inHours.remainder(24));
    final minutes = duaDigit(duration.inMinutes.remainder(60));
    final seconds = duaDigit(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'JAM'),
        SizedBox(
          width: 10,
        ),
        buildTimeCard(time: minutes, header: 'MENIT'),
        const SizedBox(
          width: 10,
        ),
        buildTimeCard(time: seconds, header: 'DETIK'),
      ],
    );
  }
}

Widget buildTimeCard({required String time, required String header}) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            time,
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E), fontSize: 80),
          ),
        ),
        SizedBox(height: 24),
        Text(header,
            style: TextStyle(
              color: Colors.white,
            ))
      ],
    );
