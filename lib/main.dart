import 'package:flutter/material.dart';

import 'src/input_data.dart';
import 'src/display_analysis.dart';
import 'src/show_and_accept_terms.dart';
import 'src/impressum.dart';
import 'src/privacy_policy_page.dart';

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
      initialRoute: '/input_data',
      routes: {
        '/input_data': (context) => const HeartDataInput(),
        '/show_and_accept_terms': (context) => const ShowAndAcceptTerms(),
        '/privacy_policy': (context) => const ShowPrivacyPolicy(),
        '/display_analysis': (context) => const DisplayOfAnalysis(),
        '/impressum': (context) => const Impressum(),
      },
    );
  }
}

