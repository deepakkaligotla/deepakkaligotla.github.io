import 'dart:convert';
import 'package:platform/platform.dart';
import 'package:http/http.dart' as http;
import 'enums.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

@JsonSerializable()
class DeviceInfo {
  bool? isLoggedIn;
  String? deviceChannel;
  String? devicePlatform;
  DateTime? lastSignInTime;
  double? deviceHeight;
  double? deviceWidth;
  String? deviceCategory;
  Map<String, dynamic>? deviceData;
  Map<String, dynamic>? deviceNetwork;

DeviceInfo({
    this.isLoggedIn,
    this.deviceChannel,
    this.devicePlatform,
    this.lastSignInTime,
    this.deviceHeight,
    this.deviceWidth,
    this.deviceCategory,
    this.deviceData,
    this.deviceNetwork,
  }) {
    isLoggedIn ??= false;
    deviceChannel ??= getDeviceChannel();
    deviceHeight ??= WidgetsBinding.instance.window.physicalSize.height;
    deviceWidth ??= WidgetsBinding.instance.window.physicalSize.width;
    deviceCategory ??= getDeviceCategory(deviceWidth!);
    initDeviceInfo();
  }

  static String getDeviceChannel() {
    if (kIsWeb) {
      return DeviceChannels.WEB.name;
    } else {
      if (const LocalPlatform().isAndroid) {
        return DeviceChannels.ANDROID.name;
      } else if (const LocalPlatform().isIOS) {
        DeviceChannels.IOS.name;
      }
    }
    return '';
  }

  static String getDeviceCategory(double screenWidth) {
    if (screenWidth < 576) return DeviceCategory.xsm.name;
    if (screenWidth < 768) return DeviceCategory.sm.name;
    if (screenWidth < 992) return DeviceCategory.md.name;
    if (screenWidth < 1200) return DeviceCategory.lg.name;
    if (screenWidth < 1400) return DeviceCategory.xl.name;
    return DeviceCategory.xxl.name;
  }

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
        isLoggedIn: json['isLoggedIn'],
        deviceChannel: json['deviceChannel'],
        devicePlatform: json['devicePlatform'],
        lastSignInTime: DateTime.tryParse(json['lastSignInTime'] ?? ''),
        deviceHeight: json['deviceHeight'],
        deviceWidth: json['deviceWidth'],
        deviceCategory: json['deviceCategory'],
        deviceData: json['deviceData']==null ? {} : Map<String, dynamic>.from(json['deviceData']),
        deviceNetwork: json['deviceNetwork']==null ? {} : Map<String, dynamic>.from(json['deviceNetwork']));
  }

  static Map<String, dynamic> toMap(DeviceInfo model) {
    return <String, dynamic>{
      'isLoggedIn': model.isLoggedIn,
      'deviceChannel': model.deviceChannel,
      'devicePlatform': model.devicePlatform,
      'lastSignInTime': model.lastSignInTime?.toIso8601String(),
      'deviceHeight': model.deviceHeight,
      'deviceWidth': model.deviceWidth,
      'deviceCategory': model.deviceCategory,
      'deviceData': model.deviceData,
      'deviceNetwork': model.deviceNetwork,
    };
  }

  static String serialize(DeviceInfo model) => jsonEncode(DeviceInfo.toMap(model));
  static DeviceInfo deserialize(String json) => DeviceInfo.fromJson(jsonDecode(json));

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final NetworkInfo networkInfo = NetworkInfo();

  initDeviceInfo() async {
    try {
      if(kIsWeb) {
        deviceData ??= await _readPlatformInfo();
        deviceNetwork ??= await _getWebNetworkDetails();
      } else if(deviceChannel == DeviceChannels.ANDROID.name || deviceChannel ==  DeviceChannels.IOS.name) {
        if(deviceChannel == DeviceChannels.ANDROID.name) {
          deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if(deviceChannel ==  DeviceChannels.IOS.name) {
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        }
        PermissionStatus permission = await Permission.locationWhenInUse.request();
        if (permission.isGranted) {
          deviceNetwork = await _readNetworkInfo(networkInfo);
        } else if(permission.isDenied || permission.isPermanentlyDenied) {
          deviceNetwork = {'Location Permission':'Not granted'};
        }
      }
    } on PlatformException {
      deviceData = {'Error': 'Failed to get platform version or network info.'};
    }
  }

  Future<Map<String, dynamic>> _getWebNetworkDetails() async {
    try {
      final response = await http.get(Uri.parse('https://ipapi.co/json/'));
      if (response.statusCode != 200) {
        return {'error': 'Failed to fetch network details, Status Code: ${response.statusCode}'};
      }
      final Map<String, dynamic> geoData = jsonDecode(response.body);
      return geoData;
    } catch (e) {
      print("Error fetching network details: $e");
      return {'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> _readNetworkInfo(NetworkInfo networkInfo) async {
    return <String, dynamic>{
      'wifiName': await networkInfo.getWifiName(),
      'wifiBSSID': await networkInfo.getWifiBSSID(),
      'wifiIPv4': await networkInfo.getWifiIP(),
      'wifiIPv6': await networkInfo.getWifiIPv6(),
      'wifiSubmask': await networkInfo.getWifiSubmask(),
      'wifiBroadcast': await networkInfo.getWifiBroadcast(),
      'wifiGatewayIP': await networkInfo.getWifiGatewayIP(),
    };
  }

  Future<Map<String, dynamic>> _readPlatformInfo() async {
    if (kIsWeb) {
      return _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
    } else if (const LocalPlatform().isAndroid) {
      return _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (const LocalPlatform().isIOS) {
      return _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    } else {
      return {'Error': 'Fuchsia platform isn\'t supported'};
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    devicePlatform = build.model;
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'serialNumber': build.serialNumber,
      'isLowRamDevice': build.isLowRamDevice,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    devicePlatform = data.model;
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    devicePlatform = '${data.browserName.name} - ${data.platform}';
    return <String, dynamic>{
      'browserName': data.browserName.name,
      'appCodeName': data.appCodeName,
      'appName': data.appName,
      'appVersion': data.appVersion,
      'deviceMemory': data.deviceMemory,
      'language': data.language,
      'languages': data.languages,
      'platform': data.platform,
      'product': data.product,
      'productSub': data.productSub,
      'userAgent': data.userAgent,
      'vendor': data.vendor,
      'vendorSub': data.vendorSub,
      'hardwareConcurrency': data.hardwareConcurrency,
      'maxTouchPoints': data.maxTouchPoints,
    };
  }

  @override
  String toString() {
    return 'DeviceInfoData{isLoggedIn: $isLoggedIn, deviceChannel: $deviceChannel, devicePlatform: $devicePlatform, deviceHeight: $deviceHeight, deviceWidth: $deviceWidth, deviceCategory: $deviceCategory, deviceData: $deviceData, deviceNetwork: $deviceNetwork}';
  }
}