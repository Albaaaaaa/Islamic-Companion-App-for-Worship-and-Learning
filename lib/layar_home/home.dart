import 'package:dakwah_y_up/about/about_project.dart';
import 'package:dakwah_y_up/bahan.dart';
import 'package:dakwah_y_up/bilah/surah_tab.dart';
import 'package:dakwah_y_up/layar_bacaan_sholat/bacaan_sholat.dart';
import 'package:dakwah_y_up/layar_chat_ai/chat_ai.dart';
import 'package:dakwah_y_up/asmaul_husna/asmaul_husna.dart';
import 'package:dakwah_y_up/layar_doa_sehari/doa.dart';
import 'package:dakwah_y_up/layar_jadwal_sholat/prayer_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: latarbelakang,
        appBar: AppBar(
          backgroundColor: surface,
          titleSpacing: 22,
          title: Row(children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: text,
                borderRadius: BorderRadius.circular(12),
              ),
              child:
                  const Icon(Icons.menu_book_rounded, color: surface, size: 20),
            ),
            const SizedBox(width: 10),
            Text("Dakwah'y up",
                style: GoogleFonts.poppins(
                    color: text, fontWeight: FontWeight.w600, fontSize: 16)),
            const Spacer(),
            IconButton(
              tooltip: 'Asmaul Husna',
              onPressed: () => _open(context, const AsmaulHusna()),
              icon: const Icon(Icons.auto_awesome_rounded, color: stroke),
            ),
          ]),
        ),
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: NestedScrollView(
              headerSliverBuilder: (context, _) => [
                SliverToBoxAdapter(child: _greeting(context)),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabHeaderDelegate(
                    Container(
                      color: latarbelakang,
                      padding: const EdgeInsets.only(top: 4, bottom: 8),
                      child: TabBar(
                        dividerColor: const Color(0xFFD8CFC3),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: stroke,
                        indicatorWeight: 3,
                        labelColor: stroke,
                        unselectedLabelColor: grey,
                        labelStyle: GoogleFonts.poppins(
                            fontSize: 13, fontWeight: FontWeight.w600),
                        tabs: const [
                          Tab(text: 'Al-Qur’an'),
                          Tab(text: 'Tentang'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              body: const TabBarView(children: [SurahTab(), About()]),
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: surface,
          indicatorColor: const Color(0xFFF0D8CD),
          selectedIndex: 0,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 72,
          onDestinationSelected: (index) {
            final pages = <Widget>[
              const HomeScreen(),
              const ChatAi(),
              const MainPage(),
              const DoaSehariPage(),
              const PrayerScheduleScreen(),
            ];
            if (index != 0) _open(context, pages[index]);
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book_rounded),
                label: 'Quran'),
            NavigationDestination(
                icon: Icon(Icons.forum_outlined),
                selectedIcon: Icon(Icons.forum_rounded),
                label: 'Asisten'),
            NavigationDestination(
                icon: Icon(Icons.accessibility_new_rounded), label: 'Bacaan'),
            NavigationDestination(
                icon: Icon(Icons.volunteer_activism_outlined),
                selectedIcon: Icon(Icons.volunteer_activism_rounded),
                label: 'Doa'),
            NavigationDestination(
                icon: Icon(Icons.schedule_rounded), label: 'Jadwal'),
          ],
        ),
      ),
    );
  }

  Widget _greeting(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Assalamu’alaikum',
              style: GoogleFonts.poppins(fontSize: 14, color: grey)),
          const SizedBox(height: 5),
          Text('Temukan tenang\ndalam setiap ayat.',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  height: 1.14,
                  fontWeight: FontWeight.w600,
                  color: text)),
          const SizedBox(height: 16),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _open(context, const PrayerScheduleScreen()),
              borderRadius: BorderRadius.circular(18),
              child: Ink(
                height: 154,
                decoration: BoxDecoration(
                    color: text, borderRadius: BorderRadius.circular(18)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(fit: StackFit.expand, children: [
                    Image.asset(
                      'assets/images/welcome-hero.jpg',
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, 0.76),
                      cacheWidth: 720,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xE626231F),
                            Color(0xB326231F),
                            Color(0x0026231F),
                          ],
                          stops: [0, .55, 1],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 16, 12, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('JADWAL IBADAH',
                              style: GoogleFonts.poppins(
                                  color: Colors.white.withValues(alpha: .84),
                                  fontSize: 10,
                                  letterSpacing: 1.35,
                                  fontWeight: FontWeight.w600)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Jaga ritme ibadahmu',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                              const SizedBox(height: 5),
                              Row(children: [
                                Text('Lihat jadwal sholat',
                                    style: GoogleFonts.poppins(
                                        color:
                                            Colors.white.withValues(alpha: .9),
                                        fontSize: 12)),
                                const SizedBox(width: 7),
                                const Icon(Icons.arrow_forward_rounded,
                                    size: 16, color: Color(0xFFE7B99F)),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Baca Al-Qur’an',
              style: GoogleFonts.poppins(
                  color: text, fontSize: 15, fontWeight: FontWeight.w600)),
        ]),
      );

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }
}

class _TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _TabHeaderDelegate(this.child);
  final Widget child;

  @override
  double get minExtent => 55;
  @override
  double get maxExtent => 55;
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;
  @override
  bool shouldRebuild(covariant _TabHeaderDelegate oldDelegate) =>
      oldDelegate.child != child;
}
