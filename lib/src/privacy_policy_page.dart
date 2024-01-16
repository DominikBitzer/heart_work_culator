import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'TUM_colors.dart';
import 'package:url_launcher/url_launcher.dart';


class ShowMdFile extends StatefulWidget {
  const ShowMdFile({super.key, required this.mdFileName});
  final String mdFileName;

  @override
  _ShowMdFileState createState() => _ShowMdFileState();
}

class _ShowMdFileState extends State<ShowMdFile> {
  final _formKey = GlobalKey<FormState>();

  String privacy_policy = "error on loading text";
  String terms_of_service = "error on loading text";

  void loadAsset() async {
    final privacyPolicy =
    await rootBundle.loadString(widget.mdFileName);
    setState(() {
      privacy_policy = privacyPolicy;
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
                    padding: const EdgeInsets.all(16),
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
