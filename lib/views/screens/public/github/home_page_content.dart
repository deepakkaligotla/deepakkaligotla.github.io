import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'github_profile_ui.dart';
import 'tab_bar_screen.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    final localStorageProvider = Provider.of<LocalStorageProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 40, 10, 20),
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
                  margin: const EdgeInsets.fromLTRB(10, 0, 80, 20),
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
