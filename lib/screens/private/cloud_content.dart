import 'package:flutter/material.dart';

class CloudContent extends StatefulWidget {
  const CloudContent({super.key});

  @override
  State<CloudContent> createState() => _CloudContent();
}

class _CloudContent extends State<CloudContent> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
        child: SingleChildScrollView(
      child: Center(
        child: Text('Cloud Development Matetial'),
      ),
    ));
  }
}
