import 'route_path.dart';
import 'package:flutter/material.dart';

class RoutesInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(RouteInformation routeInformation) async {

    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return RoutePath.mainHome('/');
    }

    if (uri.queryParameters.isNotEmpty) {
      final modifiedUri = uri.replace(path: '/');
      return RoutePath.mainHome(modifiedUri.toString());
    }

    if (uri.pathSegments.length == 1) {
      final pathName = uri.pathSegments.elementAt(0).toString();
      return RoutePath.mainHome(pathName);
    } else if (uri.pathSegments.length == 2) {
      final complexPath = "${uri.pathSegments.elementAt(0)}/${uri.pathSegments.elementAt(1)}";
      return RoutePath.mainHome(complexPath.toString());
    } else {
      return RoutePath.mainHome(uri.pathSegments.toString());
    }
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    if (configuration.isUnknown) {
      return RouteInformation(uri: Uri.parse('/error'));
    }
    if (configuration.isHomePage) {
      return RouteInformation(uri: Uri.parse('/${configuration.routeInfo!.path}'));
    }
    return RouteInformation(uri: null);
  }
}