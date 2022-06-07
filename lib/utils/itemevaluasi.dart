import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Itemevaluasi extends StatelessWidget {
  final String evaluasi;
  final DateTime tanggal;

  Itemevaluasi(this.evaluasi, this.tanggal);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            Text(evaluasi, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
            Text(
              DateFormat.yMMMMEEEEd().format(tanggal),
              style: GoogleFonts.poppins(),
            )
          ],
        ));
  }
}
