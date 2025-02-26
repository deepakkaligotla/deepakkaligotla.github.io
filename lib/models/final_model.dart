import 'device_info.dart';
import 'devices.dart';
import 'user_details.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FinalModel {
  UserDetails userDetails = UserDetails();
  DeviceInfo deviceInfo = DeviceInfo();
  Devices devices = Devices();

  bool isNotEqual(FinalModel updatedModel) {
    if(userDetails.uid.toString().compareTo(updatedModel.userDetails.uid.toString()).isOdd  ||
      userDetails.displayName.toString().compareTo(updatedModel.userDetails.displayName.toString()).isOdd ||
      userDetails.email.toString().compareTo(updatedModel.userDetails.email.toString()).isOdd ||
      userDetails.emailVerified != updatedModel.userDetails.emailVerified ||
      userDetails.isAnonymous != updatedModel.userDetails.isAnonymous ||
      userDetails.creationTime.toString().compareTo(updatedModel.userDetails.creationTime.toString()).isOdd ||
      userDetails.lastSignInTime.toString().compareTo(updatedModel.userDetails.lastSignInTime.toString()).isOdd ||
      userDetails.phoneNumber.toString().compareTo(updatedModel.userDetails.phoneNumber.toString()).isOdd ||
      userDetails.photoURL.toString().compareTo(updatedModel.userDetails.photoURL.toString()).isOdd ||
      userDetails.providerData.toString().compareTo(updatedModel.userDetails.providerData.toString()).isOdd ||
      userDetails.refreshToken.toString().compareTo(updatedModel.userDetails.refreshToken.toString()).isOdd ||
      userDetails.tenantId.toString().compareTo(updatedModel.userDetails.tenantId.toString()).isOdd ||
      UserDetails.themeModeToString(userDetails.sysDefaultTheme).toString().compareTo(UserDetails.themeModeToString(updatedModel.userDetails.sysDefaultTheme).toString()).isOdd ||
      UserDetails.colorSchemeToString(userDetails.userColorScheme).toString().compareTo(UserDetails.colorSchemeToString(updatedModel.userDetails.userColorScheme).toString()).isOdd) {
        return true;
    }

    if(deviceInfo.isLoggedIn != updatedModel.deviceInfo.isLoggedIn ||
      deviceInfo.deviceChannel.toString().compareTo(updatedModel.deviceInfo.deviceChannel.toString()).isOdd ||
      deviceInfo.devicePlatform.toString().compareTo(updatedModel.deviceInfo.devicePlatform.toString()).isOdd ||
      deviceInfo.lastSignInTime.toString().compareTo(updatedModel.deviceInfo.lastSignInTime.toString()).isOdd ||
      deviceInfo.deviceHeight != updatedModel.deviceInfo.deviceHeight ||
      deviceInfo.deviceWidth != updatedModel.deviceInfo.deviceWidth ||
      deviceInfo.deviceCategory.toString().compareTo(updatedModel.deviceInfo.deviceCategory.toString()).isOdd ||
      deviceInfo.deviceData.toString().compareTo(updatedModel.deviceInfo.deviceData.toString()).isOdd ||
      deviceInfo.deviceNetwork.toString().compareTo(updatedModel.deviceInfo.deviceNetwork.toString()).isOdd) {
        return true;
      }

    if(devices.channelDeviceCount.toString().compareTo(updatedModel.devices.channelDeviceCount.toString()).isOdd ||
      devices.activeDevices.toString().compareTo(updatedModel.devices.activeDevices.toString()).isOdd ||
      devices.currentDeviceID.toString().compareTo(updatedModel.devices.currentDeviceID.toString()).isOdd) {
        return true;
    }
    else {
      return false;
    }
  }

  @override
  String toString() {
    return '\nFinalModel{userDetails: $userDetails\n, devices: $devices\n, deviceInfo: $deviceInfo\n}';
  }
}