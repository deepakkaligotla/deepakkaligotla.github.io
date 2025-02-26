library;
import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:deepakkaligotla/app.dart';
import 'package:deepakkaligotla/providers/model_provider.dart';
import 'package:deepakkaligotla/providers/storage_providers_setup.dart';
import 'package:deepakkaligotla/core/utils/account_linker.dart';
import 'package:deepakkaligotla/providers/firestore_provider.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';
import 'package:deepakkaligotla/core/services/firebase_initializer.dart';
import 'package:deepakkaligotla/view_models/experienceViewModel.dart';
import 'package:deepakkaligotla/view_models/educationViewModel.dart';

const clientId = '364889823069-hj3143d5lfne6qkcroi69gpvlevmu726.apps.googleusercontent.com';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    setPathUrlStrategy();

    await initializeFirebase();

    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('6Le5sdkqAAAAAOClVWFk3DlCd60W59KXcCdN1Muw'),
    );

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ExperienceViewModel()),
          ChangeNotifierProvider(create: (context) => EducationViewModel()),
          ChangeNotifierProvider<ModelProvider>(create: (context) => modelProvider),
          ChangeNotifierProvider<LocalStorageProvider>(create: (context) => localStorageProvider),
          ChangeNotifierProvider<RemoteStorageProvider>(create: (context) => remoteStorageProvider),
          ChangeNotifierProxyProvider2<ModelProvider, RemoteStorageProvider, LocalStorageProvider>(
            create: (context) => Provider.of<LocalStorageProvider>(context, listen: false),
            update:(context, model, remote, local) {
              if(model.finalModel.userDetails.uid!=local!.localStorage.userDetails.uid) {
                Future.wait([linkSignedInAccount(local.localStorage)]);
              } else {
                local.updateInLocalStorage(model.finalModel).then((value) {
                  if(value) {
                    Future.wait([remote.updateInRemoteStorage(local.localStorage)]);
                  }
                });
              }
              return local;
            },
          ),
        ],
        child: const SafeArea(child: MyApp()),
      ),
    );
  }, (dynamic error, dynamic stack) {
    developer.log("Something went wrong!", error: error, stackTrace: stack);
  });
}