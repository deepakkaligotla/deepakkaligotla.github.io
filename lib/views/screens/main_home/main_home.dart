import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepakkaligotla/providers/model_provider.dart';
import 'package:deepakkaligotla/routes/route_delegate.dart';
import 'package:deepakkaligotla/routes/route_handler.dart';
import 'package:deepakkaligotla/views/widgets/deepak_app_bar.dart';
import 'package:deepakkaligotla/views/widgets/deepak_bottom_nav.dart';
import 'package:deepakkaligotla/views/widgets/deepak_drawer.dart';
import 'package:deepakkaligotla/views/widgets/theme_toggle.dart';

class MainHome extends StatefulWidget {
  final RouteInfo routeDestInfo;
  const MainHome({super.key, required this.routeDestInfo});

  @override
  State<MainHome> createState() => _MainHome();
}

class _MainHome extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelProvider>(context, listen: false);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight != modelProvider.finalModel.deviceInfo.deviceHeight ||
            constraints.maxWidth != modelProvider.finalModel.deviceInfo.deviceWidth) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            modelProvider.setConstraints(
              constraints.maxHeight,
              constraints.maxWidth,
            );
          });
        }

        return Scaffold(
          extendBody: false,
          appBar: const DeepakAppBar(),
          resizeToAvoidBottomInset: true,
          drawer: DeepakDrawer(
            onDrawerItemTap: (drawerRoute) {
              AppRouterDelegate.setPathName(drawerRoute);
            },
          ),
          bottomNavigationBar: const DeepakBottomNav(),
          body: Column(
            key: UniqueKey(),
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Stack(
                    children: [
                      RouteHandler().getRouteWidget(widget.routeDestInfo),
                      const ThemeToggle(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
