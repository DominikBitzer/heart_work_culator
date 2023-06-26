import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'TUM_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ShowMdFile extends StatefulWidget {
  const ShowMdFile({Key? key, required this.md_file_name}) : super(key: key);
  final String md_file_name;

  @override
  _ShowMdFileState createState() => _ShowMdFileState();
}

class _ShowMdFileState extends State<ShowMdFile> {
  final _formKey = GlobalKey<FormState>();

  String privacy_policy = "error on loading text";
  String terms_of_service = "error on loading text";

  void loadAsset() async {
    final _privacyPolicy =
    await rootBundle.loadString('${widget.md_file_name}');
    setState(() {
      privacy_policy = _privacyPolicy;
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
                    primary: true,
                    padding: EdgeInsets.all(16),
                    child: MarkdownBody(
                      data: privacy_policy,
                      onTapLink: (text, url, title) {
                        launchUrl(Uri.parse(url!));
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
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushNamed(
                      context,
                      '/welcome_disclaimer',
                    );
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Palette.tum_color_swatch,
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
