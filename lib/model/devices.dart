import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'enums.dart';

@JsonSerializable()
class Devices {
  Map<String, dynamic>? channelDeviceCount;
  Map<String, DateTime>? activeDevices;
  String? currentDeviceID;

  Devices({
    this.channelDeviceCount,
    this.activeDevices,
    this.currentDeviceID,
  }) {
    channelDeviceCount ??= {DeviceChannels.ANDROID.name: 0, DeviceChannels.IOS.name: 0, DeviceChannels.WEB.name: 0};
    activeDevices ??= {};
    currentDeviceID ??= '';
  }

  factory Devices.fromJson(Map<String, dynamic> json) {
    return Devices(
      channelDeviceCount: json['channelDeviceCount'],
      activeDevices: Map<String, dynamic>.from(json['activeDevices']).map((key, value) => MapEntry(key, DateTime.parse(value))),
      currentDeviceID: json['currentDeviceID']
    );
  }

  static Map<String, dynamic> toMap(Devices model) {
    return {
      'channelDeviceCount': model.channelDeviceCount,
      'activeDevices': model.activeDevices!.map((key, value) => MapEntry(key, value.toIso8601String())),
      'currentDeviceID': model.currentDeviceID
    };
  }

  static String serialize(Devices model) => jsonEncode(Devices.toMap(model));
  static Devices deserialize(String json) => Devices.fromJson(jsonDecode(json));

  @override
  String toString() {
    return 'UserDevices{channelDeviceCount: $channelDeviceCount, activeDevices: $activeDevices, currentDeviceID: $currentDeviceID}';
  }
}