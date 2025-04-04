import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:deepakkaligotla/routes/route_delegate.dart';
import 'package:deepakkaligotla/routes/route_handler.dart';
import 'package:deepakkaligotla/providers/model_provider.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileSettings();
}

class _ProfileSettings extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    return SizedBox.expand(
      child: Center(
        child: finalData.deviceInfo.isLoggedIn!
          ? ProfileScreen(
              appBar: AppBar(
                title: const Text('User Profile'),
              ),
              actions: [
                SignedOutAction((context) {
                  Provider.of<ModelProvider>(context, listen: false).logout();
                  AppRouterDelegate.setPathName(PublicRouteData.publicHome.path);
                })
              ],
              children: [
                const Divider(),
                Image.network('https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/images/logo.png', width: 100, height: 100),
              ],
            )
          : const SizedBox.expand(
              child: Center(
                child: Text('Profile Settings'),
              ),
            )
      )
    );
  }
}
