import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/model/enums.dart';
import 'package:deepakkaligotla/model/final_model.dart';
import 'package:deepakkaligotla/nav/route_delegate.dart';
import 'package:deepakkaligotla/nav/route_handler.dart';
import 'package:deepakkaligotla/res/features/general/providers/flutter_secure_storage.dart';

class DeepakBottomNav extends StatelessWidget {
  const DeepakBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    if (finalData.deviceInfo.deviceCategory == DeviceCategory.xsm.name || finalData.deviceInfo.deviceCategory == DeviceCategory.sm.name) {
      return portableScreenBottom(finalData);
    } else {
      return wideScreenBottom(finalData);
    }
  }
}

Widget portableScreenBottom(FinalModel snapshot) {
  var selectedIndex = 0;

  List<String> pages = [
    snapshot.deviceInfo.isLoggedIn! ? PrivateRouteData.privateHome.path : PublicRouteData.publicHome.path,
    PublicRouteData.profileSettings.path,
    PublicRouteData.about.path
  ];

  return BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.info),
        label: 'About',
      ),
    ],
    backgroundColor: Colors.cyan,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.white,
    currentIndex: selectedIndex,
    onTap: (value) {
      selectedIndex = value;
      AppRouterDelegate.setPathName(pages[value]);
    },
  );
}

Widget wideScreenBottom(FinalModel snapshot) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.cyan,
    ),
    child: Text(
      'Copyright ©2024, All Rights Reserved. Built with Flutter (Deepak Kaligotla)',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
          color: snapshot.userDetails.userColorScheme?.onPrimary
      ),
    ),
  );
}
