import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:deepakkaligotla/core/constants/constants.dart';

class KnowledgeText extends StatelessWidget {
  const KnowledgeText({super.key, required this.knowledge});
  final String knowledge;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding/2),
      child: Row(
        children: [
          SvgPicture.network('https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/icons/check.svg'),
          SizedBox(width: defaultPadding/2,),
          Text(knowledge),
        ],
      ),
    );
  }
}