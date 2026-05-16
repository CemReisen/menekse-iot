import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // DİKKAT: Buraya backend'i çalıştırdığında localhost.run'ın verdiği linki yazmalısın.
  // Sonuna /api/sensor/latest eklemeyi unutma!
  static const String apiUrl =
      "https://c14521ad38b493.lhr.life/api/sensor/latest";

  // Veriyi çeken asenkron fonksiyonumuz
  static Future<Map<String, dynamic>?> fetchSensorData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Gelen JSON metnini Dart'ın anlayabileceği formata çeviriyoruz
        final decodedResponse = json.decode(response.body);

        // Bizim Node.js API'miz { success: true, data: { ... } } dönüyordu.
        // O yüzden sadece 'data' kısmını uygulamanın içine gönderiyoruz.
        return decodedResponse['data'];
      } else {
        print("API Hatası: Sunucu ${response.statusCode} kodu döndürdü.");
        return null;
      }
    } catch (e) {
      print("Bağlantı Hatası (Sunucu kapalı veya internet yok): $e");
      return null;
    }
  }
}
