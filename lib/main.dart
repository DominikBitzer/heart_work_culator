import 'package:flutter/material.dart';

import 'src/input_data.dart';
import 'src/display_analysis.dart';
import 'src/show_and_accept_terms.dart';
import 'src/privacy_policy_page.dart';
import 'src/tum_colors.dart';

void main() {
  runApp(const HeartWorkCulatorApp());
}

class HeartWorkCulatorApp extends StatelessWidget {
  const HeartWorkCulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart-Work-Culator',
      theme: ThemeData(
        primarySwatch: Palette.tum_color_swatch,
        useMaterial3: false,
      ),
      initialRoute: '/input_data',
      routes: {
        '/input_data': (context) => const HeartDataInput(),
        '/welcome_disclaimer': (context) => const ShowAndAcceptTerms(),
        '/privacy_policy': (context) =>
            const ShowMdFile(mdFileName: 'assets/privacy_policy.md'),
        '/display_analysis': (context) => const DisplayOfAnalysis(),
      },
    );
  }
}
