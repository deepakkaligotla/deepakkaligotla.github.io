import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deepakkaligotla/providers/model_provider.dart';
import 'package:deepakkaligotla/providers/firestore_provider.dart';
import 'flutter_secure_storage.dart';

WebOptions getWebOptions = const WebOptions(dbName: 'FSS', publicKey: 'DeepakKaligotla');
AndroidOptions getAndroidOptions = const AndroidOptions(encryptedSharedPreferences: true, sharedPreferencesName: 'FSS', preferencesKeyPrefix: 'FSS');
IOSOptions getIOSOptions = const IOSOptions(accountName: 'FSS');

late final FlutterSecureStorage flutterSecureStorage;
late final ModelProvider modelProvider;
late final LocalStorageProvider localStorageProvider;
late final RemoteStorageProvider remoteStorageProvider;

Future<void> startLocalServices() async {
  flutterSecureStorage = FlutterSecureStorage(
    webOptions: getWebOptions,
    aOptions: getAndroidOptions,
    iOptions: getIOSOptions,
  );

  modelProvider = ModelProvider();
  localStorageProvider = LocalStorageProvider();
  remoteStorageProvider = RemoteStorageProvider();
}