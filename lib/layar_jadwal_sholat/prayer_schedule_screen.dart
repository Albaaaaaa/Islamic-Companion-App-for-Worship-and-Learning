import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:adhan/adhan.dart';
import '../services/prayer_service.dart';
import '../bahan.dart';

class PrayerScheduleScreen extends StatefulWidget {
  const PrayerScheduleScreen({super.key});

  @override
  State<PrayerScheduleScreen> createState() => _PrayerScheduleScreenState();
}

class _PrayerScheduleScreenState extends State<PrayerScheduleScreen> {
  final PrayerService _prayerService = PrayerService();
  late Future<PrayerData> _futureData;
  bool _isRefreshing = false;
  Timer? _timer;
  Duration _tick = Duration.zero;
  DateTime _lastLoadedDate = DateTime.now();

  static const Color bgColor = latarbelakang;
  static const Color cardColor = surface;
  static const Color accentGreen = stroke;
  static const Color mutedText = grey;

  @override
  void initState() {
    super.initState();
    _futureData = _prayerService.getTodayPrayerData();
    _lastLoadedDate = DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final now = DateTime.now();
      final isNewDay = now.day != _lastLoadedDate.day ||
          now.month != _lastLoadedDate.month ||
          now.year != _lastLoadedDate.year;

      if (isNewDay) {
        _lastLoadedDate = now;
        setState(() {
          _futureData = _prayerService.getTodayPrayerData();
        });
      } else {
        setState(() => _tick += const Duration(seconds: 1));
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _refreshLocation() async {
    if (mounted) setState(() => _isRefreshing = true);
    try {
      final data = await _prayerService.getTodayPrayerData();
      if (mounted) {
        setState(() => _futureData = Future.value(data));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isRefreshing = false);
    }
  }

  String _formatTime(DateTime time) => DateFormat.Hm().format(time.toLocal());

  String _formatCountdown(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    if (h > 0) return '${h}j ${m}m lagi';
    if (m > 0) return '${m}m ${s}d lagi';
    return '${s} detik lagi';
  }

  String? _getCurrentPrayerName(PrayerTimes prayerTimes) {
    final now = DateTime.now();
    final schedule = {
      'Subuh': prayerTimes.fajr,
      'Dzuhur': prayerTimes.dhuhr,
      'Ashar': prayerTimes.asr,
      'Maghrib': prayerTimes.maghrib,
      'Isya': prayerTimes.isha,
    };
    String? current;
    schedule.forEach((name, time) {
      if (now.isAfter(time)) current = name;
    });
    return current;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: surface,
        elevation: 0,
        title: const Text('Jadwal sholat',
            style: TextStyle(color: text, fontWeight: FontWeight.w700)),
        iconTheme: const IconThemeData(color: text),
      ),
      body: FutureBuilder<PrayerData>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: accentGreen));
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_off_outlined,
                        color: stroke, size: 42),
                    const SizedBox(height: 16),
                    const Text('Jadwal belum bisa dimuat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: text,
                            fontWeight: FontWeight.w700,
                            fontSize: 18)),
                    const SizedBox(height: 8),
                    Text(_friendlyError(snapshot.error),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: mutedText, height: 1.5)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentGreen,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(160, 48),
                      ),
                      onPressed: _refreshLocation,
                      icon: const Icon(Icons.my_location_rounded),
                      label: const Text('Aktifkan lokasi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final data = snapshot.data!;
          final prayerTimes = data.prayerTimes;
          final currentPrayer = _getCurrentPrayerName(prayerTimes);
          final nextPrayer = getNextPrayer(prayerTimes);

          return RefreshIndicator(
            color: accentGreen,
            backgroundColor: cardColor,
            onRefresh: _refreshLocation,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildNextPrayerHero(nextPrayer, data.cityName),
                const SizedBox(height: 20),
                _buildLocationHeader(data.cityName),
                const SizedBox(height: 16),
                _buildPrayerTile('Subuh', _formatTime(prayerTimes.fajr),
                    currentPrayer == 'Subuh'),
                _buildPrayerTile(
                    'Terbit', _formatTime(prayerTimes.sunrise), false),
                _buildPrayerTile('Dzuhur', _formatTime(prayerTimes.dhuhr),
                    currentPrayer == 'Dzuhur'),
                _buildPrayerTile('Ashar', _formatTime(prayerTimes.asr),
                    currentPrayer == 'Ashar'),
                _buildPrayerTile('Maghrib', _formatTime(prayerTimes.maghrib),
                    currentPrayer == 'Maghrib'),
                _buildPrayerTile('Isya', _formatTime(prayerTimes.isha),
                    currentPrayer == 'Isya'),
              ],
            ),
          );
        },
      ),
    );
  }

  String _friendlyError(Object? error) {
    final message = error?.toString() ?? '';
    if (message.contains('ditolak permanen')) {
      return 'Izin lokasi diblokir. Buka pengaturan aplikasi, izinkan lokasi, lalu coba lagi.';
    }
    if (message.contains('ditolak')) {
      return 'Izinkan lokasi agar jadwal sholat sesuai dengan tempatmu.';
    }
    if (message.contains('tidak aktif')) {
      return 'Nyalakan layanan lokasi di perangkat, lalu tekan tombol di bawah.';
    }
    return 'Kami belum mendapatkan lokasi perangkat. Periksa izin lokasi dan coba lagi.';
  }

  Widget _buildNextPrayerHero(NextPrayerInfo next, String cityName) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: greenGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
              right: -10,
              top: -10,
              child: Icon(Icons.mosque,
                  size: 90, color: Colors.white.withOpacity(0.08))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on,
                      size: 14, color: Colors.white70),
                  const SizedBox(width: 4),
                  Expanded(
                      child: Text(cityName,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12),
                          overflow: TextOverflow.ellipsis)),
                  _isRefreshing
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white70))
                      : IconButton(
                          tooltip: 'Perbarui lokasi',
                          onPressed: _refreshLocation,
                          padding: EdgeInsets.zero,
                          constraints:
                              const BoxConstraints(minWidth: 44, minHeight: 44),
                          icon: const Icon(Icons.refresh,
                              size: 18, color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 14),
              const Text('Sholat Berikutnya',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(next.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Text(_formatTime(next.time),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.access_time,
                        size: 14, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(_formatCountdown(next.remaining),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationHeader(String cityName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: stroke),
          const SizedBox(width: 10),
          Expanded(
              child: Text(cityName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15, color: text),
                  overflow: TextOverflow.ellipsis)),
          _isRefreshing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child:
                      CircularProgressIndicator(strokeWidth: 2, color: stroke))
              : IconButton(
                  icon: const Icon(Icons.refresh, color: stroke),
                  onPressed: _refreshLocation),
        ],
      ),
    );
  }

  Widget _buildPrayerTile(String name, String time, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE5EEE6) : cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: isActive ? stroke : const Color(0xFFDDE4DC),
            width: isActive ? 1.2 : 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: isActive ? accentGreen : mutedText,
                      shape: BoxShape.circle)),
              const SizedBox(width: 12),
              Text(name,
                  style: TextStyle(
                      color: isActive ? accentGreen : text,
                      fontWeight: FontWeight.w600,
                      fontSize: 15)),
            ],
          ),
          Text(time,
              style: TextStyle(
                  color: isActive ? accentGreen : text,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
