import 'package:deepakkaligotla/core/constants/constants.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Column(
        children: [
          const Text(
            'Native Mobile App Developer, Android(Kotlin) & iOS(Swift)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }
}
