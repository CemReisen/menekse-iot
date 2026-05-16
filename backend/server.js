const express = require('express');
const dotenv = require('dotenv');
const cors = require('cors');
const connectDB = require('./config/db.js');

// Ortam değişkenlerini yükle
dotenv.config();

// Veritabanına bağlan
connectDB();

const app = express();

// Middleware (Arka plan işleyicileri)
app.use(cors());
app.use(express.json()); // Gelen JSON verilerini okumamızı sağlar

// Test Rotası
app.get('/', (req, res) => {
  res.send('Menekşe IoT Backend Sistemi Çalışıyor...');
});

app.use('/api/sensor', require('./routes/sensorRoutes'));

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`📡 Sunucu ${PORT} portunda yayında...`);
});