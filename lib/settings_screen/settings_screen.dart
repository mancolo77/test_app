import 'package:flutter/material.dart';
import 'package:roulette_task/settings_screen/widgets/text_button.dart';
import 'package:roulette_task/task_3/third_task.dart';
import 'package:roulette_task/tast_4/fourth_task.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.onSubscribe,
    required this.isSubscribed,
  });

  final VoidCallback onSubscribe;
  final bool isSubscribed;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!widget.isSubscribed)
              TextButtonSettings(
                text: 'Получить Premium',
                onPressed: widget.onSubscribe,
              ),
            TextButtonSettings(
              text: 'Terms of Use',
              onPressed: () => _launchURL('https://google.com'),
            ),
            TextButtonSettings(
              text: 'Privacy Policy',
              onPressed: () => _launchURL('https://google.com'),
            ),
            TextButtonSettings(
              text: 'Support',
              onPressed: () => _launchURL('https://google.com'),
            ),
            TextButtonSettings(
              text: 'Перейти на задание 3',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PurchaseListView(),
                ),
              ),
            ),
            TextButtonSettings(
              text: 'Перейти на задание 4',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateFormScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}
