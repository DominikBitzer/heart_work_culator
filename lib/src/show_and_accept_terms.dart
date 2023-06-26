import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:heart_work_culator/src/TUM_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

class ShowAndAcceptTerms extends StatefulWidget {
  const ShowAndAcceptTerms({Key? key}) : super(key: key);

  @override
  _ShowAndAcceptTermsState createState() => _ShowAndAcceptTermsState();
}

class _ShowAndAcceptTermsState extends State<ShowAndAcceptTerms> {
  final _formKey = GlobalKey<FormState>();

  bool? agreedToTerms = false;

  String privacy_policy = "error on loading text";
  String terms_of_service = "error on loading text";

  void loadAsset() async {
    final _terms_of_service =
        await rootBundle.loadString('assets/terms_of_service.md');
    setState(() {
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
        title: const Text('Terms and conditions'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    primary: true,
                    padding: EdgeInsets.all(16),
                    child: MarkdownBody(
                      data: terms_of_service,
                      onTapLink: (text, url, title) {
                        launch(url!);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 65,
                child: FormField<bool>(
                  initialValue: false,
                  validator: (value) {
                    if (value == false) {
                      return 'You must agree to the terms of service.';
                    }
                    return null;
                  },
                  builder: (formFieldState) {
                    return Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: agreedToTerms,
                              onChanged: (value) {
                                // When the value of the checkbox changes,
                                // update the FormFieldState so the form is
                                // re-validated.
                                formFieldState.didChange(value);
                                setState(() {
                                  agreedToTerms = value;
                                });
                              },
                            ),

                            MarkdownBody(
                              data: "I agree to the terms of service "
                                  "\n\nand to the [privacy\u{00A0}policy](https://github.com/DominikBitzer/heart_work_culator/blob/master/assets/privacy_policy.md).",
                              onTapLink: (text, url, title) {
                                Navigator.pushNamed(
                                  context,
                                  '/privacy_policy',
                                );

                                // launch(url!);
                              },
                            ),

                            // Text(
                            //   'I agree to the terms of service and to the privacy policy.',
                            //   style: Theme.of(context).textTheme.subtitle1,
                            // ),
                          ],
                        ),
                        if (!formFieldState.isValid)
                          Text(
                            formFieldState.errorText ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Theme.of(context).errorColor),
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  var valid = _formKey.currentState!.validate();
                  if (!valid) {
                    return;
                  }

                  void _incrementCounter() async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() {
                      Type agreedToTermsType = agreedToTerms.runtimeType;
                      developer.log('agreedToTerms.runtimeType: $agreedToTermsType');
                      developer.log('agreedToTerms.runtimeType: $agreedToTerms');

                      prefs.setBool(
                          'terms_have_been_accepted', agreedToTerms ?? false);
                    });
                  }

                  _incrementCounter();

                  Navigator.pushNamed(
                    context,
                    '/input_data',
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Palette.tum_color_swatch,
                ),
                child: const Text('Agree and confirm'),
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
