import 'package:flutter/material.dart';

import 'src/input_data.dart';
import 'src/display_analysis.dart';

void main() {
  runApp(const HeartWorkCulatorApp());
}

class HeartWorkCulatorApp extends StatelessWidget {
  const HeartWorkCulatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart-Work-Culator',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const HeartDataInput(),
        '/display_analysis': (context) => const DisplayOfAnalysis(),
      },
    );
  }
}

