import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';
import 'app_search.dart';
import 'package:deepakkaligotla/models/enums.dart';
import 'package:deepakkaligotla/models/final_model.dart';
import 'package:deepakkaligotla/routes/route_delegate.dart';
import 'package:deepakkaligotla/routes/route_handler.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';

class DeepakAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DeepakAppBar({super.key});

  @override
  State<StatefulWidget> createState() => _DeepakAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DeepakAppBar extends State<DeepakAppBar> {
  late String selectedButton;
  bool profileDropdown = false;
  late final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

  @override
  void initState() {
    super.initState();
    selectedButton = 'Home';
  }

  @override
  Widget build(BuildContext context) {

    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return (finalData.deviceInfo.deviceCategory == DeviceCategory.xsm.name ||
                  finalData.deviceInfo.deviceCategory == DeviceCategory.sm.name)
              ? IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                )
              : IconButton.outlined(
                  onPressed: () {
                    AppRouterDelegate.setPathName(
                        finalData.deviceInfo.isLoggedIn!
                        ? PrivateRouteData.privateHome.path
                        : PublicRouteData.publicHome.path);
                  },
                  icon: const Icon(Symbols.home_app_logo,
                      size: kToolbarHeight - 20));
        },
      ),
      backgroundColor: finalData.userDetails.userColorScheme!.secondary,
      title: const Text('Deepak Kaligotla'),
      actions: finalData.deviceInfo.deviceCategory == DeviceCategory.sm.name ||
              finalData.deviceInfo.deviceCategory == DeviceCategory.xsm.name
          ? [
              const AppSearch(),
              IconButton(
                icon: const Icon(Icons.device_unknown_outlined),
                onPressed: () {
                  AppRouterDelegate.setPathName(
                      PublicRouteData.deviceInfo.path);
                },
              ),
            ]
          : [
              topbarButtons(finalData),
              const AppSearch(),
              IconButton(
                icon: const Icon(Icons.device_unknown_outlined),
                onPressed: () {
                  AppRouterDelegate.setPathName(
                      PublicRouteData.deviceInfo.path);
                },
              ),
            ],
    );
  }

  Widget topbarButtons(FinalModel finalData) {
    if (finalData.deviceInfo.isLoggedIn!) {
      return Row(
        children: [
          topbarButton('Projects', PrivateRouteData.projects.path),
          topbarButton('Android', PrivateRouteData.android.path),
          topbarButton('iOS', PrivateRouteData.ios.path),
          topbarButton('Hybrid', PrivateRouteData.hybrid.path),
          topbarButton('Backend', PrivateRouteData.backend.path),
          topbarButton('Cloud', PrivateRouteData.cloud.path)
        ],
      );
    } else {
      return Row(
        children: [
          topbarButton('Education', PublicRouteData.education.path),
          topbarButton('Experience', PublicRouteData.experience.path),
          topbarButton('Services', PublicRouteData.services.path),
          topbarButton('certifications', PublicRouteData.certifications.path),
          topbarButton('Contact Me', PublicRouteData.about.path)
        ],
      );
    }
  }

  topbarButton(String text, String path) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: GestureDetector(
          onTap: () {
            AppRouterDelegate.setPathName(path);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: finalData.userDetails.userColorScheme!.scrim,
              border: Border.all(),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(text),
          ),
        )
    );
  }
}
