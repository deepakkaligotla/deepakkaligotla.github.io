import 'package:flutter/material.dart';

class ServicesContent extends StatefulWidget {
  final ColorScheme userTheme;
  final double screenHeight;
  final double screenWidth;

  const ServicesContent({
    super.key,
    required this.userTheme,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  _ServicesContentState createState() => _ServicesContentState();
}

class _ServicesContentState extends State<ServicesContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Top'),
                ],
              ),
              Column(
                children: [
                  Text('center'),
                ],
              ),
              Column(
                children: [
                  Text('End'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}