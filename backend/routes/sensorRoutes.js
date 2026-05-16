const express = require('express');
const router = express.Router();
const { saveSensorData, getLatestData } = require('../controllers/sensorController');

// POST /api/sensor/data -> ESP32 buraya veri atacak
router.post('/data', saveSensorData);

// GET /api/sensor/latest -> Flutter buradan okuyacak
router.get('/latest', getLatestData);

module.exports = router;