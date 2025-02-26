import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double percent = 0;

  @override
  void initState() {
    super.initState();
    futureWithTheLoop();
  }

  void futureWithTheLoop() async {
    while (percent < 1.0) {
      setState(() {
        percent += 0.01;
      });
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(value: percent, color: Colors.white),
            Text('${(percent * 100).toStringAsFixed(0)}%', style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    )
    );
  }
}