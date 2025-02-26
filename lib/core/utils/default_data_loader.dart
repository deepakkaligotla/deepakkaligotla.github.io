import 'package:deepakkaligotla/providers/storage_providers_setup.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> loadDefaultData() async {
  if(FirebaseAuth.instance.currentUser==null) {
    await modelProvider.anonymousSignIn();
    await remoteStorageProvider.createInRemoteStorage(modelProvider.finalModel);
    await localStorageProvider.saveToLocalStorage(remoteStorageProvider.remoteStorage);
    await modelProvider.setModel(localStorageProvider.localStorage);
  } else {
    await localStorageProvider.loadFromLocalStorage();
    await remoteStorageProvider.setRemoteStorageModel(localStorageProvider.localStorage);
    await remoteStorageProvider.loadFromRemoteStorage();
    await modelProvider.setModel(remoteStorageProvider.remoteStorage);
  }
}