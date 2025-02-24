import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'res/features/general/providers/flutter_secure_storage.dart';
import 'nav/route_delegate.dart';
import 'nav/route_information_parser.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool userThemeIsDark;
  late double screenHeight;
  late double screenWidth;
  late ColorScheme userTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalStorageProvider>(builder: (context, value, child) {
      return MaterialApp.router(
        title: 'Deepak Kaligotla',
        onGenerateTitle: (context) => 'Deepak Kaligotla',
        themeMode: value.localStorage.userDetails.sysDefaultTheme,
        theme: ThemeData(useMaterial3: true,colorScheme: value.localStorage.userDetails.userColorScheme),
        routeInformationParser: RoutesInformationParser(),
        routerDelegate: AppRouterDelegate(userSnapshot: value.localStorage),
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        onNavigationNotification: (notification) => true,
      );
    });
  }
}