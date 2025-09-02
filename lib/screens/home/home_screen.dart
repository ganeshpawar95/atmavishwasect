import 'package:atmavishwasect/screens/home/affiliation_screen.dart';
import 'package:atmavishwasect/screens/home/qr_code.dart';
import 'package:atmavishwasect/utilites/helper.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://atmavishwasect.org/index.html'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: controller),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFF85A40),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.qr_code),
                    title: const Text('QR'),
                    onTap: () {
                      Helper.toRemoveUntiScreen(context, QRcodeScreen());
                      // Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text('Tie-ups'),
                    onTap: () {
                      Helper.toRemoveUntiScreen(context, AffiliationScreen());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.attach_money),
                    title: const Text('PUBLIC AID PROVIDED'),
                    onTap: () {
                      controller.loadRequest(
                        Uri.parse(
                          'https://atmavishwasect.org/reimbersment_to_members.html',
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    title: const Text('WhatsApp Call'),
                    onTap: () async {
                      final phone = '918296598888';
                      final url = 'https://wa.me/$phone';
                      final uri = Uri.parse(url);

                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Could not open WhatsApp'),
                          ),
                        );
                      }

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.menu),
        ),
      ),
    );
  }
}
