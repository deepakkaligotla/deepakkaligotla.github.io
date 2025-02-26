import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deepakkaligotla/core/services/firebase_services.dart';
import 'package:deepakkaligotla/models/device_info.dart';
import 'package:deepakkaligotla/models/devices.dart';
import 'package:deepakkaligotla/models/enums.dart';
import 'package:deepakkaligotla/models/final_model.dart';
import 'package:deepakkaligotla/models/user_details.dart';

class RemoteStorageProvider with ChangeNotifier {
  final FinalModel remoteStorage = FinalModel();
  late DocumentReference userDocument;

  Future<void> setRemoteStorageModel(FinalModel updatedModel) async {
    remoteStorage.userDetails = updatedModel.userDetails;
    remoteStorage.devices = updatedModel.devices;
    remoteStorage.deviceInfo = updatedModel.deviceInfo;
  }

  Future<void> loadFromRemoteStorage() async {
    try {
      userDocument = userCollection.doc(remoteStorage.userDetails.uid);
      DocumentSnapshot userSnapshot = await userDocument.get();
      DocumentSnapshot devicesSnapshot = (await userDocument.collection('devices').limit(1).get()).docs[0];
      DocumentSnapshot deviceInfoSnapshot = await userDocument.collection(remoteStorage.deviceInfo.deviceChannel!).doc(remoteStorage.devices.currentDeviceID).get();
      remoteStorage.userDetails = UserDetails.fromJson(userSnapshot.data() as Map<String, dynamic>);
      remoteStorage.devices = Devices.fromJson(devicesSnapshot.data() as Map<String, dynamic>);
      remoteStorage.deviceInfo = DeviceInfo.fromJson(deviceInfoSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print('Error loading data from Firestore: $e');
    }
  }

  Future<void> createInRemoteStorage(FinalModel newModel) async {
    await setRemoteStorageModel(newModel);
    try {
      userDocument = userCollection.doc(remoteStorage.userDetails.uid);
      await userDocument.set(UserDetails.toMap(remoteStorage.userDetails));
      DocumentReference deviceInfoDoc = await userDocument.collection(remoteStorage.deviceInfo.deviceChannel!).add(DeviceInfo.toMap(remoteStorage.deviceInfo));
      remoteStorage.devices.currentDeviceID = deviceInfoDoc.id;
      remoteStorage.devices.channelDeviceCount!.update(remoteStorage.deviceInfo.deviceChannel!, (oldValue) => 1);
      remoteStorage.devices.activeDevices!.putIfAbsent(deviceInfoDoc.id, () => remoteStorage.deviceInfo.lastSignInTime!);
      await userDocument.collection('devices').doc().set(Devices.toMap(remoteStorage.devices));
    } catch (e) {
      print('Error creating in Firestore: $e');
    }
  }

  Future<void> linkAccountInRemoteStorage(FinalModel linkModel) async {
    await setRemoteStorageModel(linkModel);
    try {
      userDocument = userCollection.doc(remoteStorage.userDetails.uid);
      await userDocument.get().then((value) async {
        if(value.exists) {
          remoteStorage.userDetails = UserDetails.fromJson((await userDocument.get()).data() as Map<String, dynamic>);
        } else {
          await userDocument.set(UserDetails.toMap(remoteStorage.userDetails));
        }
      });
      await userDocument.collection(remoteStorage.deviceInfo.deviceChannel!).doc(remoteStorage.devices.currentDeviceID).set(DeviceInfo.toMap(remoteStorage.deviceInfo));
      await Future.forEach(DeviceChannels.values, (channel) async {
        try {
          QuerySnapshot querySnapshot = await userDocument.collection(channel.name).get();
          remoteStorage.devices.channelDeviceCount!.update(channel.name, (oldValue) => querySnapshot.size);
          for (var doc in querySnapshot.docs) {
            if (doc.get('isLoggedIn') as bool == true) {
              remoteStorage.devices.activeDevices!.putIfAbsent(doc.id, () => DateTime.parse(doc.get('lastSignInTime')));
            }
          }
        } catch (e) {
          print("Collection ${channel.name} doesn't exist: $e");
        }
      });
      List<QueryDocumentSnapshot> devicesDoc = await userDocument.collection('devices').get().then((value) => value.docs);
      if (devicesDoc.isEmpty) {
        await userDocument.collection('devices').doc().set(Devices.toMap(remoteStorage.devices));
      } else {
        await userDocument.collection('devices').doc(devicesDoc.first.id).update(Devices.toMap(remoteStorage.devices));
      }
    } catch (e) {
      print('Error linking in Firestore: $e');
    }
  }

  Future<void> updateInRemoteStorage(FinalModel modifiedModel) async {
    userDocument = userCollection.doc(modifiedModel.userDetails.uid);
    try {
      await setRemoteStorageModel(modifiedModel);
      await userDocument.update(UserDetails.toMap(remoteStorage.userDetails));
      await userDocument.collection(remoteStorage.deviceInfo.deviceChannel!).doc(remoteStorage.devices.currentDeviceID).update(DeviceInfo.toMap(remoteStorage.deviceInfo));
    } catch (e) {
      print('Error updating in Firestore: $e');
    }
  }

  Future<void> deleteInRemoteStorage(String deleteModelUID) async {
    try {
      userDocument = userCollection.doc(deleteModelUID);
      await userDocument.collection('devices').get().then((querySnapshot) => querySnapshot.docs.forEach((doc) async {await userDocument.collection('devices').doc(doc.id).delete();}));
      DeviceChannels.values.forEach((channel) async {
        await userDocument.collection(channel.name).get().then((querySnapshot) => querySnapshot.docs.forEach((doc) async {await userDocument.collection(channel.name).doc(doc.id).delete();}));
      });
      await userDocument.delete();
    } catch (e) {
      print('Error deleting doc in Firestore: $e');
    }
  }
}