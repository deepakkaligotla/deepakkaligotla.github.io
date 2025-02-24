import 'package:flutter/material.dart';

class BackendContent extends StatefulWidget {
  const BackendContent({super.key});

  @override
  State<BackendContent> createState() => _BackendContent();
}

class _BackendContent extends State<BackendContent> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
        child: SingleChildScrollView(
      child: Center(
        child: Text('Backend, Database Material'),
      ),
    ));
  }
}
