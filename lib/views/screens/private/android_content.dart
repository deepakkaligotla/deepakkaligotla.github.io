import 'package:flutter/material.dart';

class AndroidContent extends StatefulWidget {
  const AndroidContent({super.key});

  @override
  State<AndroidContent> createState() => _AndroidContent();
}

class _AndroidContent extends State<AndroidContent> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
        child: SingleChildScrollView(
      child: Center(
        child: Text('Android Material'),
      ),
    ));
  }
}
