import 'package:dakwah_y_up/bahan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latarbelakang,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(
              16.0, 16.0, 16.0, 208.0), // Adjust bottom padding as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tentang aplikasi',
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 28, fontWeight: FontWeight.w600, color: text)),
              const SizedBox(height: 6),
              Text(
                  'Teman kecil untuk membaca, belajar, dan menjaga ritme ibadah.',
                  style: GoogleFonts.poppins(
                      fontSize: 13, height: 1.5, color: grey)),
              const SizedBox(height: 20),
              Text('Dikembangkan di Universitas Muhammadiyah Kalimantan Timur',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      letterSpacing: .4,
                      color: stroke,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 10.0),
              // Informasi untuk Mahasiswa 1
              buildMahasiswaInfo(
                'Tim pengembang 01',
                'assets/images/mahasiswa1.png', // Ubah path foto sesuai dengan nama yang Anda berikan
                'Nama : Naufal Rajwa Dwiyana Athallah',
                'NIM  : 2211102441136',
              ),
              const SizedBox(height: 10.0),
              // Informasi untuk Mahasiswa 2
              buildMahasiswaInfo(
                'Tim pengembang 02',
                'assets/images/mahasiswa2.png', // Ubah path foto sesuai dengan nama yang Anda berikan
                'Nama : Edwin Abdul Salam',
                'NIM  : 2211102441138',
              ),
              const SizedBox(height: 10.0),
              // Informasi untuk Mahasiswa 3
              buildMahasiswaInfo(
                'Tim pengembang 03',
                'assets/images/mahasiswa3.png', // Ubah path foto sesuai dengan nama yang Anda berikan
                'Nama : Muhammad Irsyadudin Islami',
                'NIM  : 2211102441128',
              ),
              const SizedBox(height: 10.0),
              // Informasi untuk Mahasiswa 4
              buildMahasiswaInfo(
                'Tim pengembang 04',
                'assets/images/mahasiswa4.png', // Ubah path foto sesuai dengan nama yang Anda berikan
                'Nama : Muhammad Ulil Albab',
                'NIM  : 2211102441104',
              ),
              const SizedBox(height: 10.0),
              Center(
                  child: Text('Kelompok 14',
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: grey))),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMahasiswaInfo(
      String title, String imagePath, String name, String description) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD8CFC3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: text,
            ),
          ),
          const SizedBox(height: 5.0),
          Row(
            children: [
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 14.0, color: text, height: 1.4),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      description,
                      style: const TextStyle(
                          fontSize: 14.0, color: grey, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
