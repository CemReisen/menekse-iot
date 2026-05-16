import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../services/api_service.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? sensorData;
  bool isLoading = true;
  Timer? _timer; // Otomatik yenileme için timer

  @override
  void initState() {
    super.initState();
    loadData();

    //Ardından her 5 saniyede bir veriyi yenilemek için timer kuruyoruz
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      loadData();
    });
  }

  // API'den veriyi çeken fonksiyonumuz
  Future<void> loadData() async {
    setState(() {
      //isLoading = true;
    });

    final data = await ApiService.fetchSensorData();

    setState(() {
      sensorData = data;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Sayfa kapanırsa arka planda veri çekmeyi durdur
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Menekşe Durum Ekranı',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
      ),
      // Aşağı kaydırarak yenileme (Pull to Refresh) özelliği ekliyoruz
      body: RefreshIndicator(
        onRefresh: loadData,
        color: Colors.deepPurple,
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.deepPurple))
            : sensorData == null
            ? ListView(
                // Hata durumunda da kaydırıp yenilemek için ListView kullanıyoruz
                children: [
                  SizedBox(height: 200),
                  Center(
                    child: Text(
                      "Veri çekilemedi. Tünel linkini kontrol et.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              )
            : _buildBody(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: loadData, // Sağ alttaki butona basarak da yenileyebiliriz
        child: Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  // Veri geldiğinde ekrana çizilecek tasarım
  Widget _buildBody() {
    // API'den gelen verileri alıyoruz
    int moisture = sensorData!['moisturePercent'] ?? 0;
    bool isRaining = sensorData!['isRaining'] ?? false;
    bool pumpTriggered = sensorData!['pumpTriggered'] ?? false;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      children: [
        Center(
          child: CircularPercentIndicator(
            radius: 130.0,
            lineWidth: 18.0,
            animation: true,
            animationDuration: 1200,
            percent: moisture / 100, // 0.0 ile 1.0 arası değer alır
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.water_drop, color: Colors.blueAccent, size: 45),
                SizedBox(height: 5),
                Text(
                  "%$moisture",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36.0,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            // Nem %30'un altındaysa kırmızı, üstündeyse yeşil bar!
            progressColor: moisture < 30 ? Colors.redAccent : Colors.green,
            backgroundColor: Colors.deepPurple.withOpacity(0.1),
          ),
        ),
        SizedBox(height: 50),
        _buildStatusCard(
          "Hava Durumu",
          isRaining ? "Yağmurlu" : "Açık",
          isRaining ? Icons.cloud : Icons.wb_sunny,
        ),
        SizedBox(height: 15),
        _buildStatusCard(
          "Motor Durumu",
          pumpTriggered ? "Çalıştı" : "Beklemede",
          Icons.settings_power,
        ),
      ],
    );
  }

  // Alt taraftaki bilgi kartlarını oluşturan yardımcı widget
  Widget _buildStatusCard(String title, String value, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Icon(icon, color: Colors.deepPurple, size: 30),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
