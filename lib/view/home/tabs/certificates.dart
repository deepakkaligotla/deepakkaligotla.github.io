import 'package:flutter/material.dart';

class Certificatestab extends StatefulWidget {
  final ColorScheme userTheme;
  final double screenHeight;
  final double screenWidth;

  const Certificatestab({
    super.key,
    required this.userTheme,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  _CertificatesTabContentState createState() => _CertificatesTabContentState();
}

class _CertificatesTabContentState extends State<Certificatestab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text('Certifications')],
      ),
    );
  }
}