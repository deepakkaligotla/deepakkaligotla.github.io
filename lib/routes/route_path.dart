import 'route_handler.dart';

class RoutePath {
  final RouteInfo? routeInfo;
  final bool isUnknown;

  RoutePath.mainHome(String? routePath) : routeInfo = RouteHandler.getRouteInfo(routePath), isUnknown = false;
  RoutePath.unknown() : routeInfo = null, isUnknown = true;

  bool get isHomePage => routeInfo != null;
}