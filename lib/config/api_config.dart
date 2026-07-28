import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;

class ApiConfig {
  /// Mengambil GEMINI_API_KEY dari file .env
  static String get geminiApiKey {
    final key = dotenv.env['GEMINI_API_KEY'];
    
    if (key == null || key.trim().isEmpty) {
      developer.log('ERROR: GEMINI_API_KEY tidak ditemukan di file .env', name: 'ApiConfig');
      throw Exception('GEMINI_API_KEY tidak ditemukan di file .env');
    }
    
    return key.trim();
  }

  /// Endpoint URL resmi Google Gemini API
  static String get geminiUrl {
    try {
      const String modelName = 'gemini-flash-lite-latest';
      final url = "https://generativelanguage.googleapis.com/v1beta/models/$modelName:generateContent?key=$geminiApiKey";
      
      developer.log('DEBUG: Gemini URL berhasil dibuat ($modelName)', name: 'ApiConfig');
      return url;
    } catch (e) {
      developer.log('ERROR: Gagal membuat Gemini URL: $e', name: 'ApiConfig');
      rethrow;
    }
  }
}