import 'package:flutter/material.dart';
import 'package:gemini_chatbot/screen/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DashboardScreen(),
    );
  }
}
