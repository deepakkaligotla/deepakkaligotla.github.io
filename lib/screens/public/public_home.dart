import 'package:deepakkaligotla/view/home/tabs/education.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/nav/route_delegate.dart';
import 'package:deepakkaligotla/nav/route_handler.dart';
import 'package:deepakkaligotla/res/features/general/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/screens/public/certifications/certifications.dart';
import 'package:deepakkaligotla/view/intro/introduction.dart';
import 'package:deepakkaligotla/view/projects/project_view.dart';
import '../../viewModel/controller.dart';

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
            Expanded(
              flex: 9,
              child: PageView(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                controller: controller,
                children: [
                  Introduction(),
                  EducationTab(),
                  ProjectsView(),
                  Certifications(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
