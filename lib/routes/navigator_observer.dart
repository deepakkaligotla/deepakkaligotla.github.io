import 'package:flutter/material.dart';

class MyNavigatorObserver extends NavigatorObserver {

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    print('Route popped: ${route.settings.name}');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    print('Route pushed: ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    print('Route removed: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace();
    if (oldRoute != null) {
      print('Route replaced: ${oldRoute.settings.name}');
    }
    if (newRoute != null) {
      print('With route: ${newRoute.settings.name}');
    }
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    print('User started a navigation gesture: ${route.settings.name}');
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    print('User stopped a navigation gesture');
  }
}
