import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:deepakkaligotla/models/device_info.dart';
import 'package:deepakkaligotla/models/devices.dart';
import 'package:deepakkaligotla/models/enums.dart';
import 'package:deepakkaligotla/models/user_details.dart';
import 'package:deepakkaligotla/models/final_model.dart';
import 'storage_providers_setup.dart';

class LocalStorageProvider extends ChangeNotifier {
  final FinalModel localStorage = FinalModel();

  Future<void> setLocalStorageModel(FinalModel updatedModel) async {
    localStorage.userDetails = updatedModel.userDetails;
    localStorage.devices = updatedModel.devices;
    localStorage.deviceInfo = updatedModel.deviceInfo;
  }

  Future<bool> loadFromLocalStorage() async {
    try {
      final storedUserJson = await flutterSecureStorage.read(key: LocalStorageKeys.userDetails.name);
      final storedDevicesJson = await flutterSecureStorage.read(key: LocalStorageKeys.devices.name);
      final storedDeviceInfoJson = await flutterSecureStorage.read(key: LocalStorageKeys.deviceDetails.name);
      if(storedUserJson!=null && storedDevicesJson!=null && storedDeviceInfoJson!=null) {
        localStorage.userDetails = UserDetails.deserialize(storedUserJson);
        localStorage.devices = Devices.deserialize(storedDevicesJson);
        localStorage.deviceInfo = DeviceInfo.deserialize(storedDeviceInfoJson);
        notifyListeners();
        return true;
      } return false;
    } catch (e) {
      print('Error loading data from LocalStorage: $e');
      return false;
    }
  }

  Future<bool> saveToLocalStorage(FinalModel newModel) async {
    try {
      await flutterSecureStorage.write(key: LocalStorageKeys.userDetails.name, value: UserDetails.serialize(newModel.userDetails));
      await flutterSecureStorage.write(key: LocalStorageKeys.devices.name, value: Devices.serialize(newModel.devices));
      await flutterSecureStorage.write(key: LocalStorageKeys.deviceDetails.name, value: DeviceInfo.serialize(newModel.deviceInfo));
      if(await loadFromLocalStorage()) return true;
      return false;
    } catch (e) {
      print('Error saving data in LocalStorage: $e');
      return false;
    }
  }

  Future<bool> updateInLocalStorage(FinalModel modifiedModel) async {
    try {
      await flutterSecureStorage.write(key: LocalStorageKeys.userDetails.name, value: UserDetails.serialize(modifiedModel.userDetails));
      await flutterSecureStorage.write(key: LocalStorageKeys.devices.name, value: Devices.serialize(modifiedModel.devices));
      await flutterSecureStorage.write(key: LocalStorageKeys.deviceDetails.name, value: DeviceInfo.serialize(modifiedModel.deviceInfo));
      if(await loadFromLocalStorage()) return true;
      return false;
    } catch (e) {
      print('Error updating data in LocalStorage: $e');
      return false;
    }
  }

  Future<bool> clearLocalStorage() async {
    try {
      await flutterSecureStorage.deleteAll();
      if(await loadFromLocalStorage()) return true;
      return false;
    } catch (e) {
      print('Error clearing data in LocalStorage: $e');
      return false;
    }
  }
}