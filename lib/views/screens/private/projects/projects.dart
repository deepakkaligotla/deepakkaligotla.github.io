import 'package:flutter/material.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  State<Projects> createState() => _Projects();
}

class _Projects extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
        child: SingleChildScrollView(
      child: Center(
        child: Text('My Projects'),
      ),
    ));
  }
}
