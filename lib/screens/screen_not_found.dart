import 'package:flutter/material.dart';

class ScreenNotFound extends StatelessWidget {

  const ScreenNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404 Not found'),
      ),
      body: const Center(
        child: Text('404 error - Screen not found!'),
      ),
    );
  }
}