import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/nav/route_delegate.dart';
import 'package:deepakkaligotla/nav/route_handler.dart';
import 'package:deepakkaligotla/res/features/general/providers/flutter_secure_storage.dart';
import 'components/animated_texts_componenets.dart';
import 'components/animated_loading_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}
class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191923),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedImageContainer(width: 100,height: 100,),
            SizedBox(height: 20),
            AnimatedLoadingText(),
            SizedBox(height: 20),
            Text('Need location permission to access this app, request to allow',
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}