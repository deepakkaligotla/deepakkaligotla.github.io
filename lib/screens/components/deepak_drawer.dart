import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/nav/route_handler.dart';
import 'package:deepakkaligotla/res/features/general/providers/flutter_secure_storage.dart';

class DeepakDrawer extends StatelessWidget {
  final void Function(String) onDrawerItemTap;

  const DeepakDrawer({
    super.key,
    required this.onDrawerItemTap,
  });

  @override
  Widget build(BuildContext context) {
    var selected = 0;
    final finalData =
        Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    List<String> pages = finalData.deviceInfo.isLoggedIn!
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
            PublicRouteData.experience.path
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
                )
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
      width: finalData.deviceInfo.deviceWidth! / 3,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: finalData.userDetails.userColorScheme?.background,
              ),
              currentAccountPicture: Image.network(
                'https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png',
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
              ],
              accountName: Text('${finalData.userDetails.displayName}'),
              accountEmail: Text('${finalData.userDetails.email}'),
            ),
          ),
          Expanded(
            child: NavigationRail(
              extended: finalData.deviceInfo.deviceWidth! > 455,
              selectedIndex: selected,
              onDestinationSelected: (value) {
                onDrawerItemTap(pages[value]);
              },
              destinations: navRailDest,
            ),
          ),
        ],
      ),
    );
  }
}
