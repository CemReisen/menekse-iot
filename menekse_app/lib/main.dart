import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MenekseApp());
}

class MenekseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menekşe Akıllı Saksı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HomeScreen(),
    );
  }
}
