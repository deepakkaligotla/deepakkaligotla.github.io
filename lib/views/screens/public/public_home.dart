import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/routes/route_delegate.dart';
import 'package:deepakkaligotla/routes/route_handler.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/views/screens/public/certifications/certifications.dart';

class PublicHome extends StatefulWidget {
  const PublicHome({super.key});

  @override
  State<PublicHome> createState() => _PublicHomeState();
}

class _PublicHomeState extends State<PublicHome> {
  @override
  Widget build(BuildContext context) {
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    return SizedBox.expand(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                finalData.deviceInfo.isLoggedIn!
                    ? AppRouterDelegate.setPathName(PrivateRouteData.privateHome.path)
                    : AppRouterDelegate.setPathName(PublicRouteData.authLogin.path);
              },
              child: Text(finalData.deviceInfo.isLoggedIn! ? "Show Content" : "Login/Signup"),
            ),
          ],
        ),
      ),
    );
  }
}
