English [EN]
# Smart Violet Pot: End-to-End IoT Ecosystem for Plant Cultivation

![smart-pot-iot-system-architecture](https://img.shields.io/badge/Architecture-Monorepo-deeppurple)
![tech-stack](https://img.shields.io/badge/Tech_Stack-Flutter%20%7C%20Node.js%20%7C%20MongoDB%20%7C%20ESP32-blue)

## Abstract

This project presents the design and implementation of an end-to-end (E2E), automated smart irrigation and monitoring ecosystem. The system captures micro-environmental metrics via an ESP32 microcontroller, archives and processes the telemetry data through a secure Node.js RESTful API backed by MongoDB, and visualizes the insights via a high-performance Flutter mobile application. The entire architecture is structured within a unified monorepo to ensure deployment efficiency and modular scaling.

## Objective

The core objective of this study is to engineer a dependable, defensive IoT infrastructure that transitions traditional plant care into an automated system. By integrating edge-validation on data ingestion and establishing real-time polling mechanisms, the project mitigates sensor anomalies and minimizes hardware memory leaks, ensuring optimal growth conditions for sensitive flora like African Violets (*Saintpaulia*).

## Methodology & System Architecture

The ecosystem relies on a three-tier architecture operating in a synchronized loop:

- **Hardware Layer (Edge Computing)**: An ESP32 microcontroller samples analog soil moisture metrics, executes localized logic, and operates a 5V relay module paired with a water pump.
- **Backend Layer (RESTful API)**: A Node.js and Express.js server handles routing, request sanitization, and database ingestion. Telemetry records are parsed and strict gourier-validation is applied before committing to MongoDB Atlas.
- **Frontend Layer (Mobile Client)**: A Flutter mobile application handles state visualization. It utilizes background timers (Polling mechanism) to securely fetch updates asynchronously without UI blocking.

## Key System Specifications

### 1. Architectural Components
- **Monorepo Design**: Segregated yet unified development environments under `backend/` and `menekse_app/` subdirectories.
- **Defensive Programming**: Gateway validation rejects anomalous input data (e.g., moisture values outside the 0–100% threshold) with standard `400 Bad Request` responses.
- **Asynchronous Polling**: Automated UI rendering refreshes silently every 5 seconds, neutralizing redundant full-screen loading indicators.

### 2. Network & Security Implementations
- **Environment Isolation**: Secure separation of database credentials using `.env` wrappers, guarded against version control via localized `.gitignore` definitions.
- **SSH Tunneling**: Secure local-to-remote reverse proxy configurations handled via `localhost.run` pipelines for instantaneous mobile-to-backend communication.

## Feature Mapping & Roadmap

| Feature Layer | Current Status | Implemented Tech / Metrics | Future Extension |
|---------------|----------------|----------------------------|------------------|
| **Telemetry** | Completed      | Soil Moisture Percent (%)  | Historical Analytics (Charts) |
| **Ingestion** | Completed      | Node.js / MongoDB Atlas    | WebSocket Integration |
| **Actuation** | Completed      | Automatic Relay Control    | Remote Manual Override |
| **Reserves** | In Progress    | Static Monitoring UI       | Ultrasonic Water Level Sensor |

## Conclusion

The structural implementation of this Monorepo framework demonstrates that low-power edge microcontrollers can be reliably coupled with modern full-stack web technologies. The integration of data validation routines successfully eliminates database poisoning from unstable sensor grids, while asynchronous UI polling provides a seamless end-user tracking experience.

## Installation & Deployment Guide

To deploy this ecosystem locally or within a simulated network:

1. **Clone the Repository:**
   ```bash
   git clone [https://github.com/CemReisen/menekse-iot.git](https://github.com/CemReisen/menekse-iot.git)
