import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/nav/route_delegate.dart';
import 'package:deepakkaligotla/nav/route_handler.dart';
import 'package:deepakkaligotla/res/features/general/providers/flutter_secure_storage.dart';

class RestrictedScreen extends StatelessWidget{
  const RestrictedScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Center(
          child: finalData.deviceInfo.isLoggedIn!
          ? const Text('Please wait checking your login')
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Access Denied to this page, please'),
              ElevatedButton(
              onPressed: () {
                AppRouterDelegate.setPathName(PublicRouteData.authLogin.path);
              },
              child:
                  const Text('Login/Signup'),
            ),
            ],
          ),
        ),
      )
    );
  }
}