import 'package:flutter/material.dart';

class Projectstab extends StatefulWidget {
  final ColorScheme userTheme;
  final double screenHeight;
  final double screenWidth;

  const Projectstab({
    super.key,
    required this.userTheme,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  _ProjectsTabContentState createState() => _ProjectsTabContentState();
}

class _ProjectsTabContentState extends State<Projectstab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text('Projects')],
      ),
    );
  }
}