import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:deepakkaligotla/routes/route_delegate.dart';
import 'package:deepakkaligotla/routes/route_handler.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/providers/model_provider.dart';

class PrivateHome extends StatefulWidget {
  const PrivateHome({super.key});

  @override
  State<PrivateHome> createState() => _PrivateHome();
}

class _PrivateHome extends State<PrivateHome> {
  @override
  Widget build(BuildContext context) {
    final finalData =
        Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    return SizedBox.expand(
        child: SingleChildScrollView(
      child: Center(
          child: Column(children: [
        Image.asset('assets/images/dash.png', width: 200, height: 200),
        Text(
          'Welcome, ${finalData.userDetails.displayName}',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Text(
          'Email: ${finalData.userDetails.email}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Phone: ${finalData.userDetails.phoneNumber}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipOval(
            child: finalData.deviceInfo.isLoggedIn!
              ? finalData.userDetails.photoURL!=null 
                ? Image.network(
                  '${finalData.userDetails.photoURL}',
                  fit: BoxFit.cover,
                )
                : Image.asset(finalData.userDetails.photoURL!, fit: BoxFit.cover)
              : Image.asset(finalData.userDetails.photoURL!, fit: BoxFit.cover)
          ),
        ),
        Text(
          'Height: ${finalData.deviceInfo.deviceHeight}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'Width: ${finalData.deviceInfo.deviceWidth}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        FilledButton.tonal(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Provider.of<ModelProvider>(context, listen: false).logout();
            AppRouterDelegate.setPathName(PublicRouteData.publicHome.path);
          },
          child: const Text('SignOut'),
        ),
      ])),
    ));
  }
}
