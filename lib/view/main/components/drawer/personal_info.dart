import 'package:flutter/material.dart';
import 'package:deepakkaligotla/res/constants/constants.dart';
import 'header_info.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: defaultPadding/2,),
        AreaInfoText(title: 'Contact', text: '+919381640235'),
        AreaInfoText(title: 'Email', text: 'deepak.kaligotla@gmail.com'),
        AreaInfoText(title: 'LinkedIn', text: '@deepakkaligotla'),
        AreaInfoText(title: 'Github', text: '@deepakkaligotla'),
        SizedBox(
          height: defaultPadding,
        ),
        Text('Skills',style: TextStyle(color: Colors.white),),
        SizedBox(
          height: defaultPadding,
        ),
      ],
    );
  }
}
