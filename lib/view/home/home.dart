import 'package:flutter/material.dart';
import 'package:deepakkaligotla/view/intro/introduction.dart';
import 'package:deepakkaligotla/view/projects/project_view.dart';
import 'package:deepakkaligotla/view/main/main_view.dart';
import 'package:deepakkaligotla/screens/public/certifications/certifications.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainView(pages: [
      const Introduction(),
      ProjectsView(),
      Certifications(),
    ]);
  }
}