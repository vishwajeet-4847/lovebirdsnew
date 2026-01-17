import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlViewScreen extends StatefulWidget {
  const HtmlViewScreen({super.key});

  @override
  State<HtmlViewScreen> createState() => _HtmlViewScreenState();
}

class _HtmlViewScreenState extends State<HtmlViewScreen> {
  final String htmlData = """
    <h4>Privacy Policy for Figgy</h4>
    <h5>How We Use Your Information</h5>
    <h6>Personal Information:</h6>
    <p>We use your email address for account management and to communicate with you about updates or important information.</p>
    <h6>Usage Data:</h6>
    <p>We analyze usage patterns to improve our app's content and user experience.</p>
    <h6>Device Information:</h6>
    <p>We use device information for technical purposes, such as troubleshooting and ensuring compatibility.</p>
    <h6>Information Sharing</h6>
    <p>We do not sell, trade, or otherwise transfer your personally identifiable information to third parties.</p>
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Html(
          data: htmlData,
          style: {
            "body": Style(fontSize: FontSize(18)),
            "h4": Style(fontSize: FontSize(24), fontWeight: FontWeight.bold),
            "h5": Style(fontSize: FontSize(22)),
            "h6": Style(fontSize: FontSize(20)),
            "p": Style(fontSize: FontSize(18), lineHeight: const LineHeight(1.6)),
          },
        ),
      ),
    );
  }
}
