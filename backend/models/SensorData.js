const mongoose = require('mongoose');

const sensorDataSchema = new mongoose.Schema({
  deviceId: {
    type: String,
    default: 'menekse-01'
  },
  moisturePercent: {
    type: Number,
    required: true
  },
  isRaining: {
    type: Boolean,
    default: false
  },
  pumpTriggered: {
    type: Boolean,
    default: false
  }
}, { 
  timestamps: true 
});

module.exports = mongoose.model('SensorData', sensorDataSchema);