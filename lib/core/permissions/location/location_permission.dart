import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class LocationPermission extends StatefulWidget {
  const LocationPermission({super.key});

  @override
  State<LocationPermission> createState() => LocationPermissionState();
}

class LocationPermissionState extends State<LocationPermission> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Permission.location.status.isGranted,
      builder: (context, snapshot) {
        final finalData =
            Provider.of<LocalStorageProvider>(
              context,
              listen: true,
            ).localStorage;

        return Scaffold(
          backgroundColor: Color(0xFF191923),
          body: Center(
            child:
                snapshot.data! == false
                    ? Text(
                      'Location permission is required to use this app',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    : Text(
                      'Error occurred while requesting permissions',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          ),
        );
      },
    );
  }
}
