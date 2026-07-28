import 'package:dakwah_y_up/about/about_project.dart';
import 'package:dakwah_y_up/bahan.dart';
import 'package:dakwah_y_up/bilah/surah_tab.dart';
import 'package:dakwah_y_up/layar_bacaan_sholat/bacaan_sholat.dart';
import 'package:dakwah_y_up/layar_chat_ai/chat_ai.dart';
import 'package:dakwah_y_up/layar_doa_sehari/doa.dart';
import 'package:dakwah_y_up/asmaul_husna/asmaul_husna.dart';
import 'package:dakwah_y_up/layar_jadwal_sholat/prayer_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latarbelakang,
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: _greeting(),
              ),
              SliverAppBar(
                pinned: true,
                elevation: 0,
                backgroundColor: latarbelakang,
                automaticallyImplyLeading: false,
                shape: Border(bottom: BorderSide(color: latarbelakang)),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: _tab(),
                ),
              )
            ],
            body: const TabBarView(
              children: [SurahTab(), About()],
            ),
          ),
        ),
      ),
    );
  }

  TabBar _tab() {
    return TabBar(
      unselectedLabelColor: text,
      labelColor: Colors.white,
      indicatorColor: stroke,
      indicatorWeight: 3,
      tabs: [
        _tabItem(label: "Surah"),
        _tabItem(label: "About Project")
      ],
    );
  }

  Tab _tabItem({required String label}) =>
      Tab(child: Text(label, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)));

  Column _greeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assalamualaikum',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: text),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Muslim',
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: grey),
        ),
        const SizedBox(
          height: 24,
        ),
        _lastRead()
      ],
    );
  }

  Stack _lastRead() {
    return Stack(
      children: [
        Container(
          height: 131,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                Color(0xFF1C6758),
                Color(0xFF4C726C),
              ])),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset('assets/svgs/mid_quran.svg'),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/svgs/buku_kecil.svg'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Al-Quran',
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Find solace in the Quran",
                style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "amidst life's chaos",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: latarbelakang,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/svgs/navbar_menu_home.svg'),
          ),
          Text(
            "Dakwah'y up",
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/svgs/pencarian_menu_home.svg'),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: footer,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        _footerBarItem(icon: "assets/svgs/footer_quran.svg", label: "quran"),
        _footerBarItem(icon: "assets/svgs/footer_lampu.svg", label: "Lampu"),
        _footerBarItem(icon: "assets/svgs/footer_orang_duduk.svg", label: "Icon Orang Duduk"),
        _footerBarItem(icon: "assets/svgs/footer_tangan_berdoa.svg", label: "Icon Tangan Berdoa"),
        _footerBarItem(icon: "assets/svgs/buku_kecil.svg", label: "Jadwal Sholat"),
        _footerBarItem(icon: "assets/svgs/footer_simpan.svg", label: "Icon Simpan"),
      ],
      onTap: (index) {
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatAi()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
        } else if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DoaSehariPage()));
        } else if (index == 4) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AsmaulHusna()));
        } else if (index == 5) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PrayerScheduleScreen()));
        }
      },
    );
  }

  BottomNavigationBarItem _footerBarItem({required String icon, required String label}) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(icon),
      label: label,
    );
  }
}
