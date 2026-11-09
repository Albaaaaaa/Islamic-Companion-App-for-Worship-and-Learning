import 'package:dakwah_y_up/bahan.dart';
import 'package:dakwah_y_up/layar_home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latarbelakang,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 700;
            return Padding(
              padding: EdgeInsets.fromLTRB(24, compact ? 14 : 22, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.asset(
                          'assets/images/icon-modern.png',
                          width: 42,
                          height: 42,
                          fit: BoxFit.cover,
                          cacheWidth: 168,
                          semanticLabel: 'Logo Dakwah Y Up',
                        ),
                      ),
                      const SizedBox(width: 11),
                      Text(
                        "Dakwah'y up",
                        style: GoogleFonts.poppins(
                          color: text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: compact ? 22 : 30),
                  Text(
                    'RUANG UNTUK MENDEKAT',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      letterSpacing: 1.8,
                      color: stroke,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tenangkan hati,\nkuatkan iman.',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: compact ? 31 : 35,
                      height: 1.08,
                      color: text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 9),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 340),
                    child: Text(
                      'Qur’an, doa, dan jadwal sholat dalam satu teman harian.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        height: 1.5,
                        color: grey,
                      ),
                    ),
                  ),
                  SizedBox(height: compact ? 14 : 20),
                  Expanded(
                    child: Semantics(
                      image: true,
                      label:
                          'Mushaf di ruang ibadah yang diterangi cahaya fajar',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/images/welcome-hero.jpg',
                              fit: BoxFit.cover,
                              alignment: const Alignment(0, 0.45),
                              cacheWidth: 900,
                            ),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0x00000000),
                                    Color(0x14000000),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 14,
                              bottom: 14,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: surface.withValues(alpha: .94),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.wb_twilight_rounded,
                                      size: 16,
                                      color: stroke,
                                    ),
                                    const SizedBox(width: 7),
                                    Text(
                                      'Mulai dari satu langkah',
                                      style: GoogleFonts.poppins(
                                        color: text,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: compact ? 14 : 18),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (_) => const HomeScreen(),
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: stroke,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: Text(
                        'Mulai sekarang',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
