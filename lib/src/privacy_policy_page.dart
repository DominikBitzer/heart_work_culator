import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ShowPrivacyPolicy extends StatefulWidget {
  const ShowPrivacyPolicy({Key? key}) : super(key: key);

  @override
  _ShowPrivacyPolicyState createState() => _ShowPrivacyPolicyState();
}

class _ShowPrivacyPolicyState extends State<ShowPrivacyPolicy> {
  final _formKey = GlobalKey<FormState>();

  String privacy_policy = "error on loading text";
  String terms_of_service  = "error on loading text";

  void loadAsset() async {
    final _privacyPolicy = await rootBundle.loadString('assets/privacy_policy.md');
    final _terms_of_service = await rootBundle.loadString('assets/terms_of_service.md');
    setState(() {
      privacy_policy = _privacyPolicy;
      terms_of_service = _terms_of_service;
    });
  }

  @override
  void initState() {
    super.initState();
    loadAsset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy policy'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: MarkdownBody(
                      data: privacy_policy,
                      onTapLink: (text, url, title) {
                        launch(url!);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Navigator.canPop(context))
                  {
                    Navigator.pop(context);
                  }
                  else {
                    Navigator.pushNamed(
                      context,
                      '/welcome_disclaimer',
                    );

                  }


                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: const Text('Back'),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
