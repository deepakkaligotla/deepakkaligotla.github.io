import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/firebase_services.dart';
import 'core/services/stream_data_listener.dart';
import 'core/utils/default_data_loader.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/providers/storage_providers_setup.dart';
import 'package:deepakkaligotla/routes/route_delegate.dart';
import 'package:deepakkaligotla/routes/route_information_parser.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    loadApp();
  }

  Future<void> loadApp() async {
    startFirebaseServices();
    await startLocalServices();
    await loadDefaultData();
    await listenToFirestoreChanges();
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