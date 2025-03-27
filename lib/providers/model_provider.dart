import 'package:deepakkaligotla/models/device_info.dart';
import 'package:deepakkaligotla/models/enums.dart';
import 'package:deepakkaligotla/models/final_model.dart';
import 'package:deepakkaligotla/providers/storage_providers_setup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ChangeNotifier;

class ModelProvider with ChangeNotifier {
  final FinalModel finalModel = FinalModel();

  setModel(FinalModel updatedModel) {
    finalModel.userDetails = updatedModel.userDetails;
    finalModel.devices = updatedModel.devices;
    finalModel.deviceInfo = updatedModel.deviceInfo;
  }

  Future<void> notifyRemoteStorageUpdates(FinalModel remoteStorage) async {
    setModel(remoteStorage);
    notifyListeners();
  }

  Future<void> setConstraints(double maxHeight, double maxWidth) async {
    if (finalModel.deviceInfo.deviceHeight == maxHeight && finalModel.deviceInfo.deviceWidth == maxWidth) {
      return;
    }
    finalModel.deviceInfo.deviceHeight = maxHeight;
    finalModel.deviceInfo.deviceWidth = maxWidth;
    finalModel.deviceInfo.deviceCategory = DeviceInfo.getDeviceCategory(maxWidth);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    finalModel.userDetails.sysDefaultTheme = (finalModel.userDetails.sysDefaultTheme == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    finalModel.userDetails.userColorScheme = (finalModel.userDetails.sysDefaultTheme == ThemeMode.dark) ? const ColorScheme.dark() : const ColorScheme.light();
    notifyListeners();
  }

  Future<void> login(User? user) async {
    finalModel.deviceInfo.isLoggedIn = true;
    finalModel.deviceInfo.lastSignInTime = user!.metadata.lastSignInTime;
    finalModel.userDetails.uid = user.uid;
    finalModel.userDetails.displayName = user.displayName;
    finalModel.userDetails.email = user.displayName;
    finalModel.userDetails.emailVerified = user.emailVerified;
    finalModel.userDetails.isAnonymous = user.isAnonymous;
    finalModel.userDetails.creationTime = user.metadata.creationTime;
    finalModel.userDetails.lastSignInTime = user.metadata.lastSignInTime;
    finalModel.userDetails.phoneNumber = user.phoneNumber;
    finalModel.userDetails.photoURL = user.photoURL;
    finalModel.userDetails.providerData = user.providerData.map((userInfo) => _userInfoToMap(userInfo)).toList();
    finalModel.userDetails.refreshToken = user.refreshToken;
    finalModel.userDetails.tenantId = user.tenantId;
    notifyListeners();
  }

  Map<String, dynamic> _userInfoToMap(UserInfo userInfo) {
    return {
      'uid': userInfo.uid,
      'displayName': userInfo.displayName,
      'email': userInfo.email,
      'phoneNumber': userInfo.phoneNumber,
      'photoURL': userInfo.photoURL,
      'providerId': userInfo.providerId,
    };
  }

  Future<void> logout() async {
    finalModel.deviceInfo.isLoggedIn = false;
    await remoteStorageProvider.updateInRemoteStorage(finalModel);
    await anonymousSignIn();
  }

  Future<void> anonymousSignIn() async {
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    finalModel.deviceInfo.isLoggedIn = false;
    finalModel.deviceInfo.lastSignInTime = userCredential.user!.metadata.lastSignInTime;
    finalModel.userDetails.uid = userCredential.user!.uid;
    finalModel.userDetails.emailVerified = userCredential.user!.emailVerified;
    finalModel.userDetails.isAnonymous = userCredential.user!.isAnonymous;
    finalModel.userDetails.creationTime = userCredential.user!.metadata.creationTime;
    finalModel.userDetails.lastSignInTime = userCredential.user!.metadata.lastSignInTime;
    finalModel.userDetails.refreshToken = userCredential.user!.refreshToken;
    finalModel.devices.channelDeviceCount = {DeviceChannels.ANDROID.name: 0, DeviceChannels.IOS.name: 0, DeviceChannels.WEB.name: 0};
    finalModel.devices.activeDevices = {};
    finalModel.userDetails.displayName = null;
    finalModel.userDetails.email = null;
    finalModel.userDetails.phoneNumber = null;
    finalModel.userDetails.photoURL = null;
    finalModel.userDetails.providerData = [];
    finalModel.userDetails.refreshToken = null;
    finalModel.userDetails.tenantId = null;
    notifyListeners();
  }
}