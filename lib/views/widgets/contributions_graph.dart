import 'package:flutter/material.dart';

class ContributionsGraph extends StatelessWidget {
  final List<int> contributions; // Each value represents intensity (0-5)

  const ContributionsGraph({Key? key, required this.contributions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: contributions.map((intensity) {
        return Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: _getColorForIntensity(intensity),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }).toList(),
    );
  }

  Color _getColorForIntensity(int intensity) {
    switch (intensity) {
      case 0:
        return Colors.grey[300]!;
      case 1:
        return Colors.green[100]!;
      case 2:
        return Colors.green[300]!;
      case 3:
        return Colors.green[500]!;
      case 4:
        return Colors.green[700]!;
      default:
        return Colors.green[900]!;
    }
  }
}