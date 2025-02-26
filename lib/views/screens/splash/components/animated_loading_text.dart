import 'package:flutter/material.dart';

class AnimatedLoadingText extends StatelessWidget {
  const AnimatedLoadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20 * 5,
      child: TweenAnimationBuilder(duration: const Duration(seconds: 2),builder: (context, value, child) => Column(
        children: [
          LinearProgressIndicator(
            backgroundColor: Colors.black,
            color: Colors.deepPurpleAccent,
            value: value,
          ),
          const SizedBox(height: 20/2),
          Text(
            '${(value * 100).toInt()}%',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,shadows: [
            Shadow(color: Colors.purple,blurRadius: 10 , offset: Offset(2,2)),
            Shadow(color: Colors.teal,blurRadius: 10 , offset: Offset(-2,-2)),
          ]))
        ],
      ), tween: Tween(begin: 0.0,end: 1.0)),
    );
  }
}