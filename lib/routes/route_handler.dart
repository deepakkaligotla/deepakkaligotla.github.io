import 'package:deepakkaligotla/views/screens/auth/auth_screen.dart';
import 'package:deepakkaligotla/views/screens/private/android_content.dart';
import 'package:deepakkaligotla/views/screens/private/backend_content.dart';
import 'package:deepakkaligotla/views/screens/private/cloud_content.dart';
import 'package:deepakkaligotla/views/screens/private/hybrid_content.dart';
import 'package:deepakkaligotla/views/screens/private/ios_content.dart';
import 'package:deepakkaligotla/views/screens/private/private_home.dart';
import 'package:deepakkaligotla/views/screens/private/profile_settings.dart';
import 'package:deepakkaligotla/views/screens/private/projects.dart';
import 'package:deepakkaligotla/views/screens/private/restricted_screen.dart';
import 'package:deepakkaligotla/views/screens/public/about.dart';
import 'package:deepakkaligotla/views/screens/public/device_info.dart';
import 'package:deepakkaligotla/views/screens/public/education.dart';
import 'package:deepakkaligotla/views/screens/public/exprience.dart';
import 'package:deepakkaligotla/views/screens/public/public_home.dart';
import 'package:deepakkaligotla/views/screens/screen_not_found.dart';
import 'package:deepakkaligotla/views/screens/splash/splash.dart';
import 'package:flutter/material.dart';

class RouteInfo {
  final String path;
  final Widget widget;
  final bool isPrivate;

  RouteInfo({required this.path, required this.widget, required this.isPrivate});
}

class RouteData {
  static RouteInfo base = RouteInfo(path: '/', widget: const SplashView(), isPrivate: false);
}

class PublicRouteData {
  static RouteInfo publicHome = RouteInfo(path: 'public/home', widget: const PublicHome(), isPrivate: false);
  static RouteInfo about = RouteInfo(path: 'public/about', widget: const About(), isPrivate: false);
  static RouteInfo education = RouteInfo(path: 'public/education', widget: const EducationScreen(), isPrivate: false);
  static RouteInfo experience = RouteInfo(path: 'public/experience', widget: const ExperienceScreen(), isPrivate: false);
  static RouteInfo profileSettings = RouteInfo(path: 'profile/settings', widget: const ProfileSettings(), isPrivate: false);
  static RouteInfo services = RouteInfo(path: 'public/services', widget: const PublicHome(), isPrivate: false);
  static RouteInfo authLogin = RouteInfo(path: 'auth/login', widget: const AuthScreen(), isPrivate: false);
  static RouteInfo deviceInfo = RouteInfo(path: 'device/info', widget: const DeviceInfoScreen(), isPrivate: false);
  static RouteInfo notFound = RouteInfo(path: 'error', widget: const ScreenNotFound(), isPrivate: false);
  static RouteInfo restricted = RouteInfo(path: 'restricted', widget: const RestrictedScreen(), isPrivate: false);
}

class PrivateRouteData {
  static RouteInfo privateHome = RouteInfo(path: 'private/home', widget: const PrivateHome(), isPrivate: true);
  static RouteInfo projects = RouteInfo(path: 'private/projects', widget: const Projects(), isPrivate: true);
  static RouteInfo android = RouteInfo(path: 'private/android', widget: const AndroidContent(), isPrivate: true);
  static RouteInfo ios = RouteInfo(path: 'private/ios', widget: const IOSContent(), isPrivate: true);
  static RouteInfo hybrid = RouteInfo(path: 'private/hybrid', widget: const HybridContent(), isPrivate: true);
  static RouteInfo backend = RouteInfo(path: 'private/backend', widget: const BackendContent(), isPrivate: true);
  static RouteInfo cloud = RouteInfo(path: 'private/cloud', widget: const CloudContent(), isPrivate: true);
}

class RouteHandler {
  static final RouteHandler _instance = RouteHandler._();
  factory RouteHandler() => _instance;
  RouteHandler._();

  Widget getRouteWidget(RouteInfo routeDest) {
    return routeDest.widget;
  }

  static RouteInfo getRouteInfo(String? routePath) {
    switch (routePath) {
      //Base Routes
      case '/':
        return PublicRouteData.publicHome;

      // Public Routes
      case 'public/home':
        return PublicRouteData.publicHome;
      case 'public/about':
        return PublicRouteData.about;
      case 'public/education':
        return PublicRouteData.education;
      case 'public/experience':
        return PublicRouteData.experience;
      case 'profile/settings':
        return PublicRouteData.profileSettings;
      case 'public/services':
        return PublicRouteData.publicHome;
      case 'device/info':
        return PublicRouteData.deviceInfo;
      case 'auth/login':
        return PublicRouteData.authLogin;
      case 'error':
        return PublicRouteData.notFound;
      case 'restricted':
        return PublicRouteData.restricted;

      // Private Routes
      case 'private/home':
        return PrivateRouteData.privateHome;
      case 'private/projects':
        return PrivateRouteData.projects;
      case 'private/android':
        return PrivateRouteData.android;
      case 'private/ios':
        return PrivateRouteData.ios;
      case 'private/hybrid':
        return PrivateRouteData.hybrid;
      case 'private/backend':
        return PrivateRouteData.backend;
      case 'private/cloud':
        return PrivateRouteData.cloud;

      default:
        return PublicRouteData.notFound;
    }
  }
}