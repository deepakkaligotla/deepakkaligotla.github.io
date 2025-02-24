import 'package:flutter/material.dart';

class PrivacyPolicyContent extends StatefulWidget {
  final ColorScheme userTheme;
  final double screenHeight;
  final double screenWidth;

  const PrivacyPolicyContent({
    super.key,
    required this.userTheme,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  _PrivacyPolicyContentState createState() => _PrivacyPolicyContentState();
}

class _PrivacyPolicyContentState extends State<PrivacyPolicyContent> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Privacy Policy Content'),
    );
  }
}