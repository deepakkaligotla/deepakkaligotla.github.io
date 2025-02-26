import 'dart:async';
import 'package:deepakkaligotla/core/permissions/location/location_permission.dart';
import 'package:flutter/material.dart';
import 'package:deepakkaligotla/core/services/firebase_services.dart';
import 'package:deepakkaligotla/core/services/stream_data_listener.dart';
import 'package:deepakkaligotla/core/utils/default_data_loader.dart';
import 'package:deepakkaligotla/providers/storage_providers_setup.dart';
import 'components/animated_loading_text.dart';
import 'components/animated_texts_components.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
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