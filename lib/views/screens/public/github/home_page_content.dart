import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'github_profile_ui.dart';
import 'tab_bar_screen.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 50, 10, 20),
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GitHubProfileUI(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(width: 0.5, color: Colors.grey),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.fromLTRB(10, 40, 80, 20),
                  child: const GitTabBar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
