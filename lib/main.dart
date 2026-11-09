import 'package:dakwah_y_up/bahan.dart';
import 'package:dakwah_y_up/layar_depan/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load();
  } catch (_) {
    // Optional API configuration should not prevent the companion from opening.
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      title: "Dakwah'y up",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: stroke, brightness: Brightness.light, surface: surface),
        useMaterial3: true,
        scaffoldBackgroundColor: latarbelakang,
        appBarTheme: const AppBarTheme(
          backgroundColor: surface,
          foregroundColor: text,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: surface,
          indicatorColor: Color(0xFFF0D8CD),
          elevation: 0,
          labelTextStyle: WidgetStateProperty.resolveWith((states) => TextStyle(
                color: states.contains(WidgetState.selected) ? stroke : grey,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              )),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFD8CFC3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFD8CFC3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: stroke, width: 2),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
