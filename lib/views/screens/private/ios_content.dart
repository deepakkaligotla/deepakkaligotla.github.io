import 'package:flutter/material.dart';

class IOSContent extends StatefulWidget {
  const IOSContent({super.key});

  @override
  State<IOSContent> createState() => _IOSContent();
}

class _IOSContent extends State<IOSContent> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
        child: SingleChildScrollView(
      child: Center(
        child: Text('iOS Material'),
      ),
    ));
  }
}
