import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PrayerService {
  Future<PrayerData> getTodayPrayerData() async {
    try {
      final position = await _getLocation();
      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;

      final now = DateTime.now();
      final dateComponents = DateComponents(now.year, now.month, now.day);
      final prayerTimes = PrayerTimes(coordinates, dateComponents, params);
      final cityName = await _getCityName(position.latitude, position.longitude);

      return PrayerData(
        prayerTimes: prayerTimes,
        cityName: cityName,
        latitude: position.latitude,
        longitude: position.longitude,
        date: now,
      );
    } catch (e) {
      throw Exception('Gagal mengambil jadwal sholat: $e');
    }
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location service tidak aktif');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Izin lokasi ditolak');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Izin lokasi ditolak permanen');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 10),
    );
  }

  Future<String> _getCityName(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return place.locality ?? place.subAdministrativeArea ?? place.administrativeArea ?? 'Unknown';
      }
      return 'Unknown';
    } catch (e) {
      return 'Lokasi: ${latitude.toStringAsFixed(2)}, ${longitude.toStringAsFixed(2)}';
    }
  }
}

class PrayerData {
  final PrayerTimes prayerTimes;
  final String cityName;
  final double latitude;
  final double longitude;
  final DateTime date;

  PrayerData({
    required this.prayerTimes,
    required this.cityName,
    required this.latitude,
    required this.longitude,
    required this.date,
  });
}

class NextPrayerInfo {
  final String name;
  final DateTime time;
  final Duration remaining;

  NextPrayerInfo({
    required this.name,
    required this.time,
    required this.remaining,
  });
}

NextPrayerInfo getNextPrayer(PrayerTimes prayerTimes) {
  final now = DateTime.now();
  final schedule = {
    'Subuh': prayerTimes.fajr,
    'Dzuhur': prayerTimes.dhuhr,
    'Ashar': prayerTimes.asr,
    'Maghrib': prayerTimes.maghrib,
    'Isya': prayerTimes.isha,
  };

  for (final entry in schedule.entries) {
    if (entry.value.isAfter(now)) {
      return NextPrayerInfo(
        name: entry.key,
        time: entry.value,
        remaining: entry.value.difference(now),
      );
    }
  }

  final tomorrowFajr = prayerTimes.fajr.add(const Duration(days: 1));
  return NextPrayerInfo(
    name: 'Subuh',
    time: tomorrowFajr,
    remaining: tomorrowFajr.difference(now),
  );
}