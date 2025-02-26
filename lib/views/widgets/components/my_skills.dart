import 'package:flutter/material.dart';
import 'package:deepakkaligotla/core/constants/constants.dart';

class AnimatedLinearProgressIndicator extends StatelessWidget {
  const AnimatedLinearProgressIndicator({super.key, required this.percentage, required this.title, this.imageUrl});
  final double percentage;
  final String title;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(bottom: defaultPadding/2),
      child: TweenAnimationBuilder(tween: Tween(begin: 0.0,end: percentage), duration: const Duration(seconds: 1), builder: (context, value, child) {
        return Column(
          children: [
            Row(
              children: [
                Image.network(imageUrl!, height: 15, width: 15, fit: BoxFit.cover,),
                const SizedBox(width: 5,),
                Text(title,style: const TextStyle(color: Colors.white),),
                const Spacer(),
                Text('${(value*100).toInt().toString()}%'),
              ],
            ),
            const SizedBox(height: defaultPadding/2,),
            LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.black,
              color: Colors.amberAccent,
            ),
          ],
        );
      },),
    );
  }
}

class MySKills extends StatelessWidget {
  const MySKills({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills',style: TextStyle(color: Colors.white)),
        Divider(),
        AnimatedLinearProgressIndicator(percentage: 0.7, title: 'Flutter', imageUrl: 'https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/icons/flutter.png',),
        AnimatedLinearProgressIndicator(percentage: 0.9, title: 'Dart', imageUrl: 'https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/icons/dart.png'),
        AnimatedLinearProgressIndicator(percentage: 0.6, title: 'Firebase', imageUrl: 'https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/icons/firebase.png'),
        AnimatedLinearProgressIndicator(percentage: 0.85, title: 'Sqlite', imageUrl: 'https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/icons/dart.png'),
        AnimatedLinearProgressIndicator(percentage: 0.8, title: 'Responsive Design', imageUrl: 'https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/icons/flutter.png'),
        AnimatedLinearProgressIndicator(percentage: 0.9, title: 'Clean Architecture', imageUrl: 'https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/icons/flutter.png'),
        AnimatedLinearProgressIndicator(percentage: 0.5, title: 'Bloc', imageUrl: 'https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/icons/bloc.png'),
        AnimatedLinearProgressIndicator(percentage: 0.93, title: 'Getx', imageUrl: 'https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/icons/dart.png'),
      ]);
  }
}