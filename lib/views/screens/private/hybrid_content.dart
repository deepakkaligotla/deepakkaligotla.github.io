import 'package:flutter/material.dart';

class HybridContent extends StatefulWidget {
  const HybridContent({super.key});

  @override
  State<HybridContent> createState() => _HybridContent();
}

class _HybridContent extends State<HybridContent> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
        child: SingleChildScrollView(
      child: Center(
        child: Text('Hybrid Material'),
      ),
    ));
  }
}
