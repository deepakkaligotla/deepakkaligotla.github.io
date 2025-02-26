import 'package:firebase_auth/firebase_auth.dart';
import 'package:deepakkaligotla/providers/storage_providers_setup.dart';
import 'firebase_services.dart';

Future<void> listenToFirestoreChanges() async {
  if (FirebaseAuth.instance.currentUser != null) {
    localStorageProvider.loadFromLocalStorage().then((value) async {
      if (value) {
        try {
          final userDocument = userCollection.doc(localStorageProvider.localStorage.userDetails.uid);
          userDocument.snapshots().listen((userSnapshot) async {
            if (userSnapshot.exists) {
              await remoteStorageProvider.loadFromRemoteStorage();
              modelProvider.notifyRemoteStorageUpdates(remoteStorageProvider.remoteStorage);
            }
          });
          userDocument.collection('devices').doc().snapshots().listen((devicesSnapshot) async {
            if (devicesSnapshot.exists) {
              await remoteStorageProvider.loadFromRemoteStorage();
              modelProvider.notifyRemoteStorageUpdates(remoteStorageProvider.remoteStorage);
            }
          });
          userDocument.collection(localStorageProvider.localStorage.deviceInfo.deviceChannel!).doc(localStorageProvider.localStorage.devices.currentDeviceID).snapshots().listen((currentDeviceSnapshot) async {
            if (currentDeviceSnapshot.exists) {
              await remoteStorageProvider.loadFromRemoteStorage();
              modelProvider.notifyRemoteStorageUpdates(remoteStorageProvider.remoteStorage);
            }
          });
        } catch (e) {
          print('Error streaming data from Firestore: $e');
        }
      }
    });
  }
}
