# 🪴 Menekşe Akıllı Saksı (IoT Ekosistemi)

Uçtan uca (End-to-End) tasarlanmış, çift yönlü iletişime sahip akıllı bitki sulama ve takip sistemi. 

Bu proje; donanım, arka uç (backend) ve mobil uygulama olmak üzere üç ana ayaktan oluşan bir **Monorepo** mimarisidir. ESP32 üzerinden okunan sensör verileri Node.js tabanlı REST API'ye iletilir, MongoDB üzerinde arşivlenir ve Flutter ile geliştirilmiş mobil arayüzde gerçek zamanlı (Polling/WebSocket) olarak görselleştirilir.

## 🚀 Kullanılan Teknolojiler (Tech Stack)

* **Mobil Uygulama (Frontend):** Flutter, Dart (State Management & API Integration)
* **Arka Uç (Backend):** Node.js, Express.js (RESTful API Design)
* **Veritabanı:** MongoDB Atlas, Mongoose (Schema Validation)
* **Donanım (IoT):** ESP32, Toprak Nem Sensörü, 5V Röle, Su Pompası
* **Ağ & İletişim:** HTTP/HTTPS protokolleri, ngrok/localhost.run (SSH Tünelleme)

## 📁 Klasör Mimarisi

Proje tek bir depo (Monorepo) üzerinden yönetilmektedir:
* `backend/` : Node.js sunucu kodlarını, veritabanı şemalarını ve API rotalarını (Controller) içerir.
* `menekse_app/` : Android ve iOS için derlenebilen, asenkron HTTP istekleri atabilen Flutter mobil uygulamasını içerir.

## ⚙️ Kurulum ve Çalıştırma

Projeyi kendi bilgisayarınızda çalıştırmak için:

1. **Projeyi Klonlayın:**
   ```bash
   git clone [https://github.com/CemReisen/menekse-iot.git](https://github.com/CemReisen/menekse-iot.git)
