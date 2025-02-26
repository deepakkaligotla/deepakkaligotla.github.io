import 'package:deepakkaligotla/core/constants/constants.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/routes/route_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  double groupAlignment = -1.0;

  @override
  Widget build(BuildContext context) {
    final finalData =
        Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    List<String> pages =
        finalData.deviceInfo.isLoggedIn!
            ? [
              PrivateRouteData.privateHome.path,
              PublicRouteData.education.path,
              PublicRouteData.experience.path,
              PrivateRouteData.projects.path,
              PrivateRouteData.android.path,
              PrivateRouteData.ios.path,
              PrivateRouteData.hybrid.path,
              PrivateRouteData.cloud.path,
            ]
            : [
              PublicRouteData.publicHome.path,
              PublicRouteData.education.path,
              PublicRouteData.experience.path,
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
                label: Text('Flutter'),
                selectedIcon: Icon(Icons.flutter_dash),
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
            ];

    return Drawer(
      width: finalData.deviceInfo.deviceWidth! / 2,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: finalData.userDetails.userColorScheme?.background,
              ),
              currentAccountPicture: Image.network(
                'https://raw.githubusercontent.com/deepakkaligotla/deepakkaligotla.github.io/refs/heads/main/assets/images/logo.png',
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
                    child: Image.network('${finalData.userDetails.photoURL}', fit: BoxFit.cover),
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
          const About(),
          Expanded(
            child: NavigationRail(
              useIndicator: true,
              groupAlignment: groupAlignment,
              extended: finalData.deviceInfo.deviceWidth! > 455,
              selectedIndex: _selectedIndex,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: bgColor,
                    child: const Padding(
                      padding: EdgeInsets.all(defaultPadding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MySKills(),
                          Knowledge(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
