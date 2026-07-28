import 'package:dakwah_y_up/bahan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DoaSehariPage extends StatelessWidget {
  const DoaSehariPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: latarbelakang,
        title: Text(
          "Doa Sehari-hari",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: stroke,
          ),
        ),
        centerTitle: true,
      ),
      body: _PageList(),
      backgroundColor: latarbelakang,
    );
  }
}

class DoaSehari {
  final String nama;
  final String isi;
  final String arti;
  final IconData icon;
  final LinearGradient gradient;

  DoaSehari({
    required this.nama,
    required this.isi,
    required this.arti,
    required this.icon,
    required this.gradient,
  });
}

class DetailPage extends StatelessWidget {
  final DoaSehari doa;

  const DetailPage({super.key, required this.doa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latarbelakang,
      appBar: AppBar(
        backgroundColor: latarbelakang,
        elevation: 0,
        title: Text(
          doa.nama,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: doa.gradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      doa.icon,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      doa.nama,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Bacaan Arab:',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: stroke,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: stroke.withOpacity(0.3)),
                ),
                child: Text(
                  doa.isi,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    height: 1.8,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Arti:',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: stroke,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: accentGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: accentGreen.withOpacity(0.3)),
                ),
                child: Text(
                  doa.arti,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageList extends StatelessWidget {
  final List<DoaSehari> doaList = [
    DoaSehari(
      nama: "Doa Sebelum Makan",
      isi: "اَللّٰهُمَّ بَارِكْ لَنَا فِيْمَا رَزَقْتَنَا وَقِنَا عَذَابَ النَّارِ",
      arti:
          "Artinya: Ya Allah, berkahilah kami dalam rezeki yang telah Engkau berikan kepada kami dan peliharalah kami dari siksa api neraka",
      icon: Icons.lunch_dining_rounded,
      gradient: orangeGradient,
    ),
    DoaSehari(
      nama: "Doa Setelah Makan",
      isi: "اَلْحَمْدُ ِللهِ الَّذِىْ اَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِيْنَ",
      arti:
          "Artinya: Segala puji bagi Allah yang telah memberi makan kami dan minuman kami, serta menjadikan kami sebagai orang-orang islam",
      icon: Icons.done_all_rounded,
      gradient: greenGradient,
    ),
    DoaSehari(
      nama: "Doa Ketika Lupa Berdoa",
      isi: "بِسْمِ اللهِ فِىِ أَوَّلِهِ وَآخِرِهِ",
      arti: "Artinya: Dengan menyebut nama Allah pada awal dan akhirnya",
      icon: Icons.lightbulb_rounded,
      gradient: blueGradient,
    ),
    DoaSehari(
      nama: "Doa Sebelum Tidur",
      isi: "بِسْمِكَ الللّٰهُمَّ اَحْيَا وَاَمُوْتُ",
      arti: "Artinya: Dengan menyebut nama-Mu ya Allah, aku hidup dan aku mati",
      icon: Icons.nights_stay_rounded,
      gradient: purpleGradient,
    ),
    DoaSehari(
      nama: "Doa Bangun Tidur",
      isi: "اَلْحَمْدُ ِللهِ الَّذِىْ اَحْيَانَا بَعْدَمَآ اَمَاتَنَا وَاِلَيْهِ النُّشُوْرُ",
      arti:
          "Artinya: Segala puji bagi Allah yang telah menghidupkan kami sesudah kami mati (membangunkan dari tidur) dan hanya kepada-Nya kami dikembalikan",
      icon: Icons.wb_sunny_rounded,
      gradient: tealGradient,
    ),
    DoaSehari(
      nama: "Doa Mimpi Buruk",
      isi: "اَللّٰهُمَّ إِنّىِ أَعُوْذُ بِكَ مِنْ عَمَلِ الشَّيْطَانِ وَسَيِّئاَتِ اْلأَحْلاَمِ",
      arti: "Artinya: Ya Allah, aku berlindung kepada-Mu dari perbuatan setan dan mimpi-mimpi buruk",
      icon: Icons.sentiment_dissatisfied_rounded,
      gradient: const LinearGradient(
        colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    DoaSehari(
      nama: "Doa Mimpi Baik",
      isi: "اَلْحَمْدُ ِللهِ الَّذِيْ قَطْلَ الْحَاجَتِ",
      arti: "Artinya: Segala puji bagi Allah yang telah memenuhi hajatku",
      icon: Icons.sentiment_satisfied_rounded,
      gradient: greenGradient,
    ),
    DoaSehari(
      nama: "Doa Masuk Kamar Mandi",
      isi: "اَللّٰهُمَّ كَمَا حَسَّنْتَ خَلْقِىْ فَحَسِّـنْ خُلُقِىْ",
      arti:
          "Artinya: Ya Allah, sebagaimana Engkau telah menciptakan tubuhku dengan baik, maka sempurnakanlah akhlakku",
      icon: Icons.water_drop_rounded,
      gradient: blueGradient,
    ),
    DoaSehari(
      nama: "Doa Keluar Kamar Mandi",
      isi: "غُفْرَانَكَ الْحَمْدُ ِللهِ الَّذِىْ اَذْهَبَ عَنّى اْلاَذَى وَعَافَانِىْ",
      arti:
          "Artinya: Dengan menyebut namaMu ya Allah, aku berlindung kepadaMu dari kejahatan yang ada pada diriku",
      icon: Icons.check_circle_rounded,
      gradient: tealGradient,
    ),
    DoaSehari(
      nama: "Doa Sebelum Belajar",
      isi:
          "اَللّٰهُمَّ افْتَحْ عَلَىَّ حِكْمَتَكَ وَانْشُرْ عَلَىَّ رَحْمَتَكَ وَذَكِّرْنِىْ مَانَسِيْتُ",
      arti:
          "Artinya: Ya Allah, bukakanlah atas diriku hikmat-Mu dan hamparkanlah rahmat-Mu kepadaku",
      icon: Icons.school_rounded,
      gradient: purpleGradient,
    ),
    DoaSehari(
      nama: "Doa Masuk Rumah",
      isi: "بِسْمِ اللهِ الَّذِىْ لاَ اِلَهَ اِلاَّ هُوَ",
      arti: "Artinya: Dengan menyebut nama Allah yang tiada Tuhan selain-Nya",
      icon: Icons.home_rounded,
      gradient: greenGradient,
    ),
    DoaSehari(
      nama: "Doa Keluar Rumah",
      isi: "بِسْمِ اللهِ تَوَكَّلْتُ عَلَى اللهِ لاَحَوْلَ وَلاَقُوَّةَ اِلاَّ بِالله",
      arti:
          "Artinya: Dengan nama Allah aku bertawakal kepada Allah, tiada daya kekuatan melainkan dengan pertolongan Allah",
      icon: Icons.exit_to_app_rounded,
      gradient: orangeGradient,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      itemCount: doaList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(doa: doaList[index]),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                gradient: doaList[index].gradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      doaList[index].icon,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      doaList[index].nama.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white.withOpacity(0.7),
                    size: 18,
                  ),
                ],
              ),
            ),
          ).animate().slideX(
                duration: const Duration(milliseconds: 400),
                begin: -0.2,
                end: 0,
              ),
        );
      },
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: DoaSehariPage(),
    ),
  );
}