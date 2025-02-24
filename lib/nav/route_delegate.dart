import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ChangeNotifier;
import 'package:deepakkaligotla/model/final_model.dart';
import 'package:deepakkaligotla/nav/custom_navigation_key.dart';
import 'package:deepakkaligotla/nav/custom_transition_delegate.dart';
import 'package:deepakkaligotla/nav/navigator_observer.dart';
import 'package:deepakkaligotla/nav/route_handler.dart';
import 'package:deepakkaligotla/nav/route_path.dart';
import 'package:deepakkaligotla/screens/main_home.dart';

class AppRouterDelegate extends RouterDelegate<RoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final AppRouterDelegate _instance = AppRouterDelegate._();

  FinalModel? userSnapshot;
  RouteInfo? routeNameInfo;
  bool isError = false;

  factory AppRouterDelegate({required FinalModel userSnapshot}) {
    _instance.userSnapshot = userSnapshot;
    return _instance;
  }

  AppRouterDelegate._();

  TransitionDelegate transitionDelegate = CustomTransitionDelegate();

  @override
  RoutePath get currentConfiguration {
    if (isError) return RoutePath.unknown();
    if (routeNameInfo == null) RoutePath.mainHome(PublicRouteData.publicHome.path);
    return RoutePath.mainHome(routeNameInfo?.path);
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey =>
      CustomNavigationKeys.navigatorKey;

  List<Page> get _appStack => [
        MaterialPage(
          key: const ValueKey(''),
          child:routeNameInfo!=null ? MainHome(routeDestInfo: routeNameInfo!) : MainHome(routeDestInfo: PublicRouteData.publicHome),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Navigator(
      transitionDelegate: transitionDelegate,
      key: navigatorKey,
      pages: _appStack,
      observers: [MyNavigatorObserver()],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        routeNameInfo = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    if (configuration.isHomePage) {
      if (configuration.routeInfo != null) {
        if (userSnapshot!.deviceInfo.isLoggedIn!) {
          routeNameInfo = configuration.routeInfo;
          isError = false;
        } else {
          if (configuration.routeInfo!.isPrivate) {
            routeNameInfo = PublicRouteData.restricted;
            isError = false;
          } else {
            routeNameInfo = configuration.routeInfo;
            isError = false;
          }
        }
      } else {
        routeNameInfo = PublicRouteData.publicHome;
        isError = false;
      }
    } else {
      routeNameInfo = RouteData.base;
      isError = true;
    }
    notifyListeners();
  }

  static void setPathName(String path) {
    _instance.setNewRoutePath(RoutePath.mainHome(path));
    _instance.notifyListeners();
  }
}