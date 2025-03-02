import 'package:deepakkaligotla/core/constants/constants.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/routes/route_handler.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../models/device_info.dart';
import 'components/about.dart';
import 'components/contact_icons.dart';
import 'components/knowledge.dart';
import 'components/my_skills.dart';

class DeepakDrawer extends StatefulWidget {
  final void Function(String) onDrawerItemTap;
  const DeepakDrawer({super.key, required this.onDrawerItemTap});

  @override
  State<DeepakDrawer> createState() => _DeepakDrawerState();
}

class _DeepakDrawerState extends State<DeepakDrawer> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;

  @override
  Widget build(BuildContext context) {
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    List<String> pages =
        finalData.deviceInfo.isLoggedIn!
            ? [
              PrivateRouteData.privateHome.path,
              PrivateRouteData.projects.path,
              PrivateRouteData.android.path,
              PrivateRouteData.ios.path,
              PrivateRouteData.hybrid.path,
              PrivateRouteData.backend.path,
              PrivateRouteData.cloud.path,
            ]
            : [
              PublicRouteData.publicHome.path,
              PublicRouteData.education.path,
              PublicRouteData.experience.path,
              PublicRouteData.services.path,
              PublicRouteData.certifications.path,
              PublicRouteData.about.path,
            ];

    List<NavigationRailDestination> navRailDest =
        (finalData.deviceInfo.isLoggedIn!)
            ? const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                label: Text('Home'),
                selectedIcon: Icon(Icons.home_filled),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.code_outlined),
                label: Text('Projects'),
                selectedIcon: Icon(Icons.code),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.android_outlined),
                label: Text('Android'),
                selectedIcon: Icon(Icons.android),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.apple_outlined),
                label: Text('iOS'),
                selectedIcon: Icon(Icons.apple),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.flutter_dash_outlined),
                label: Text('Hybrid'),
                selectedIcon: Icon(Icons.flutter_dash),
              ),
          NavigationRailDestination(
            icon: Icon(Symbols.database_rounded),
            label: Text('Backend'),
            selectedIcon: Icon(Symbols.database),
          ),
              NavigationRailDestination(
                icon: Icon(Icons.cloud_sync_outlined),
                label: Text('Cloud'),
                selectedIcon: Icon(Icons.cloud_sync),
              ),
            ]
            : const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                label: Text('Home'),
                selectedIcon: Icon(Icons.home_filled),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.cast_for_education_outlined),
                label: Text('Education'),
                selectedIcon: Icon(Icons.cast_for_education),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.work_history_outlined),
                label: Text('Experience'),
                selectedIcon: Icon(Icons.work_history),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.design_services_outlined),
                label: Text('Services'),
                selectedIcon: Icon(Icons.design_services),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.verified_user_outlined),
                label: Text('Certifications'),
                selectedIcon: Icon(Icons.verified_user),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.info_outline),
                label: Text('Contact Me'),
                selectedIcon: Icon(Icons.info),
              ),
            ];

    double _getDrawerWidth(DeviceInfo deviceInfo) {
      switch (deviceInfo.deviceCategory) {
        case 'xsm': return deviceInfo.deviceWidth! * 0.5; // Extra Small Screens (Phones)
        case 'sm': return deviceInfo.deviceWidth! * 0.5;  // Small Screens (Folded Phones)
        case 'md': return deviceInfo.deviceWidth! * 0.4;  // Medium Screens (Tablets)
        case 'lg': return deviceInfo.deviceWidth! * 0.3;  // Large Screens (Laptops)
        case 'xl': return deviceInfo.deviceWidth! * 0.3;  // Extra Large Screens
        case 'xxl': return deviceInfo.deviceWidth! * 0.3; // Huge Screens
        default: return deviceInfo.deviceWidth! * 0.5;    // Default to 50%
      }
    }

    return Drawer(
      width: _getDrawerWidth(finalData.deviceInfo),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: finalData.userDetails.userColorScheme?.background,
              ),
              currentAccountPicture: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(
                  'https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              otherAccountsPictures: [
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
                    child: Image.network(
                      '${finalData.userDetails.photoURL}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
              accountName: Text(
                'Deepak Kaligotla',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              accountEmail: Text(
                'deepak.kaligotla@gmail.com',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          Expanded(
            child: NavigationRail(
              useIndicator: true,
              groupAlignment: -1.0,
              selectedIndex: _selectedIndex,
              labelType: labelType,
              onDestinationSelected: (value) {
                setState(() {
                  widget.onDrawerItemTap(pages[value]);
                  setState(() {
                    _selectedIndex = value;
                  });
                });
              },
              destinations: navRailDest,
              trailing: ContactIcon(),
            ),
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       children: [
          //         Container(
          //           color: bgColor,
          //           child: const Padding(
          //             padding: EdgeInsets.all(defaultPadding / 2),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [MySKills(), Knowledge()],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}