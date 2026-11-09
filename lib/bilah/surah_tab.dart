import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dakwah_y_up/bahan.dart';
import 'package:dakwah_y_up/models/surah.dart';
import 'package:dakwah_y_up/detail_layar/detail_layar.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future<List<Surah>> _getSurahList() async {
    String data = await rootBundle.loadString('assets/data/daftar-surah.json');
    return surahFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
        future: _getSurahList(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: stroke));
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Daftar surah belum dapat dimuat.',
                    style: TextStyle(color: grey)));
          }
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          return ListView.separated(
              itemBuilder: (context, index) => _surahItem(
                  context: context, surah: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Color(0xFFD8CFC3)),
              itemCount: snapshot.data!.length);
        }));
  }

  Widget _surahItem({required Surah surah, required BuildContext context}) =>
      InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailScreen(
                    noSurat: surah.nomor,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0D8CD),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: stroke.withValues(alpha: .28)),
                ),
                child: Center(
                  child: Text(
                    '${surah.nomor}',
                    style: GoogleFonts.poppins(
                        color: stroke, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.namaLatin,
                    style: GoogleFonts.poppins(
                        color: text, fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        surah.tempatTurun.name,
                        style: GoogleFonts.poppins(
                            color: grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: grey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${surah.jumlahAyat} Ayat",
                        style: GoogleFonts.poppins(
                            color: grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ],
                  )
                ],
              )),
              Text(
                surah.nama,
                style: GoogleFonts.amiri(
                    color: stroke, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
}
