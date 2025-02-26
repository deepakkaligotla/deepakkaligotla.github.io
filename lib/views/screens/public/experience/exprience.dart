import 'package:flutter/material.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreen();
}

class _ExperienceScreen extends State<ExperienceScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: SingleChildScrollView(
      child: Center(
        child: SafeArea(
            child: Text('Experience')
        ),
      ),
    ));
  }
}
