const SensorData = require('../models/SensorData');

// 1. ESP32'den gelen veriyi veritabanına kaydet (GÜVENLİ VERSİYON)
const saveSensorData = async (req, res) => {
  try {
    const { moisturePercent, isRaining, pumpTriggered } = req.body;
    
    // --- 1. GÜMRÜK KONTROLÜ: Veri eksik mi? ---
    if (moisturePercent === undefined || typeof isRaining !== 'boolean' || typeof pumpTriggered !== 'boolean') {
      return res.status(400).json({
        success: false,
        message: "HATA: Eksik veya hatalı veri formatı! (Nem, yagmur ve motor durumu zorunludur.)"
      });
    }

    // --- 2. MANTIK KONTROLÜ: Nem değeri 0-100 arasında mı? ---
    if (moisturePercent < 0 || moisturePercent > 100) {
      return res.status(400).json({
        success: false,
        message: "HATA: Mantıksız sensör verisi! Nem değeri 0 ile 100 arasında olmalıdır."
      });
    }

    // Kontrollerden geçtiyse veritabanına yaz
    const newData = await SensorData.create({
      moisturePercent,
      isRaining,  
      pumpTriggered
    });

    res.status(201).json({ success: true, data: newData });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// 2. Flutter uygulaması için en son eklenen 1 kaydı getir (BUNA DOKUNMADIK)
const getLatestData = async (req, res) => {
  try {
    // createdAt'e göre tersten sıralayıp (-1) en üsttekini alıyoruz
    const latestData = await SensorData.findOne().sort({ createdAt: -1 });
    
    if (!latestData) {
      return res.status(404).json({ success: false, message: 'Henüz veri yok' });
    }

    res.status(200).json({ success: true, data: latestData });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = { saveSensorData, getLatestData };