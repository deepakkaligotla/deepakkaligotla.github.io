import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'default_data_loader.dart';
import 'package:deepakkaligotla/app.dart';
import 'package:deepakkaligotla/views/screens/splash/splash.dart';
import 'package:deepakkaligotla/providers/storage_providers_setup.dart';
import 'package:deepakkaligotla/core/services/firebase_services.dart';
import 'package:deepakkaligotla/core/services/stream_data_listener.dart';

class LocationPermission extends StatefulWidget {
  const LocationPermission({super.key});

  @override
  State<LocationPermission> createState() => LocationPermissionState();
}

class LocationPermissionState extends State<LocationPermission> {
  late Future<PermissionStatus> _status;

  @override
  void initState() {
    super.initState();
    _status = requestLocationPermission();
  }

  Future<PermissionStatus> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted || await Permission.location.isGranted) {
      loadApp();
    }
    return status;
  }

  Future<void> loadApp() async {
    startFirebaseServices();
    await startLocalServices();
    await loadDefaultData();
    await listenToFirestoreChanges();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PermissionStatus>(
      future: _status,
      builder: (context, snapshot) {
        return Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
                backgroundColor: Color(0xFF191923),
                body: Center(
                  child: snapshot.connectionState == ConnectionState.waiting ?
                  SplashView() :
                  snapshot.hasError ?
                  Text('Error occurred while requesting permissions', style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold)) :
                  snapshot.data!.isDenied || snapshot.data!.isPermanentlyDenied ?
                  Text('Location permission is required to use this app', style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold)) :
                  MyApp(),
                )
            )
        );
      },
    );
  }
}