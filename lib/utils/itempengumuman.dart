import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class ItemPengumuman extends StatelessWidget {
  final String pengumuman;
  final DateTime tanggal;

  ItemPengumuman(this.pengumuman, this.tanggal);

  @override
  Widget build(BuildContext context) {
    // Intl.defaultLocale = 'id';
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          SelectableText(pengumuman,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 16)),
          SelectableText(
            DateFormat.yMMMMEEEEd().format(tanggal),
            style: GoogleFonts.poppins(),
          )
        ],
      ),
    );
  }
}
