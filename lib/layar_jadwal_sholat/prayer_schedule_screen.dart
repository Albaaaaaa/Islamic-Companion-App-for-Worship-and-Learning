import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:adhan/adhan.dart';
import '../services/prayer_service.dart';

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

  static const Color bgColor = Color(0xFF141225);
  static const Color cardColor = Color(0xFF1E1B36);
  static const Color accentGreen = Color(0xFF3ECF8E);
  static const Color mutedText = Color(0xFF8B8A9E);

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
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text('Jadwal Sholat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<PrayerData>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: accentGreen));
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}', style: const TextStyle(color: mutedText)),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: accentGreen),
                    onPressed: _refreshLocation,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Coba Lagi'),
                  ),
                ],
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
                _buildPrayerTile('Subuh', _formatTime(prayerTimes.fajr), currentPrayer == 'Subuh'),
                _buildPrayerTile('Terbit', _formatTime(prayerTimes.sunrise), false),
                _buildPrayerTile('Dzuhur', _formatTime(prayerTimes.dhuhr), currentPrayer == 'Dzuhur'),
                _buildPrayerTile('Ashar', _formatTime(prayerTimes.asr), currentPrayer == 'Ashar'),
                _buildPrayerTile('Maghrib', _formatTime(prayerTimes.maghrib), currentPrayer == 'Maghrib'),
                _buildPrayerTile('Isya', _formatTime(prayerTimes.isha), currentPrayer == 'Isya'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNextPrayerHero(NextPrayerInfo next, String cityName) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2E8B6F), Color(0xFF163D30)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(right: -10, top: -10, child: Icon(Icons.mosque, size: 90, color: Colors.white.withOpacity(0.08))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.white70),
                  const SizedBox(width: 4),
                  Expanded(child: Text(cityName, style: const TextStyle(color: Colors.white70, fontSize: 12), overflow: TextOverflow.ellipsis)),
                  _isRefreshing ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white70))
                      : GestureDetector(onTap: _refreshLocation, child: const Icon(Icons.refresh, size: 16, color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 14),
              const Text('Sholat Berikutnya', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(next.name, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Text(_formatTime(next.time), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(_formatCountdown(next.remaining), style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
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
        gradient: const LinearGradient(colors: [Color(0xFF1F6F5C), Color(0xFF14382E)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(child: Text(cityName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white), overflow: TextOverflow.ellipsis)),
          _isRefreshing ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : IconButton(icon: const Icon(Icons.refresh, color: Colors.white), onPressed: _refreshLocation),
        ],
      ),
    );
  }

  Widget _buildPrayerTile(String name, String time, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: isActive ? accentGreen.withOpacity(0.15) : cardColor,
        borderRadius: BorderRadius.circular(14),
        border: isActive ? Border.all(color: accentGreen, width: 1.2) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: isActive ? accentGreen : mutedText, shape: BoxShape.circle)),
              const SizedBox(width: 12),
              Text(name, style: TextStyle(color: isActive ? accentGreen : Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
            ],
          ),
          Text(time, style: TextStyle(color: isActive ? accentGreen : Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}