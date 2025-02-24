import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserDetails {
  String? uid;
  String? displayName;
  String? email;
  bool? emailVerified;
  bool? isAnonymous;
  DateTime? creationTime;
  DateTime? lastSignInTime;
  String? phoneNumber;
  String? photoURL;
  List<Map<String, dynamic>>? providerData;
  String? refreshToken;
  String? tenantId;
  ThemeMode? sysDefaultTheme;
  ColorScheme? userColorScheme;

  UserDetails({
      this.uid,
      this.displayName,
      this.email,
      this.emailVerified,
      this.isAnonymous,
      this.creationTime,
      this.lastSignInTime,
      this.phoneNumber,
      this.photoURL,
      this.providerData,
      this.refreshToken,
      this.tenantId,
      this.sysDefaultTheme,
      this.userColorScheme}) {
    photoURL ??= 'assets/images/profile_photo.png';
    sysDefaultTheme ??= PlatformDispatcher.instance.platformBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    userColorScheme ??= PlatformDispatcher.instance.platformBrightness == Brightness.dark ? const ColorScheme.dark() : const ColorScheme.light();
  }

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      uid: json['uid'],
      displayName: json['displayName']=='' ? null : json['displayName'],
      email: json['email'] == '' ? null : json['email'],
      emailVerified: json['emailVerified'],
      isAnonymous: json['isAnonymous'],
      creationTime: DateTime.parse(json['creationTime']),
      lastSignInTime: DateTime.parse(json['lastSignInTime']),
      phoneNumber: json['phoneNumber'] == '' ? null : json['phoneNumber'],
      photoURL: json['photoURL'] == '' ? null : json['photoURL'],
      providerData: json['providerData'] == '' ? [] : (json['providerData'] as List<dynamic>).map((userInfo) => userInfo as Map<String, dynamic>).toList(),
      refreshToken: json['refreshToken'],
      tenantId: json['tenantId'] == '' ? null : json['tenantId'],
      sysDefaultTheme: _stringToThemeMode(json['sysDefaultTheme']),
      userColorScheme: _stringToColorScheme(json['userColorScheme']),
    );
  }

  static Map<String, dynamic> toMap(UserDetails model) {
    return {
      'uid': model.uid,
      'displayName': model.displayName ?? '',
      'email': model.email ?? '',
      'emailVerified': model.emailVerified,
      'isAnonymous': model.isAnonymous,
      'creationTime': model.creationTime!.toIso8601String(),
      'lastSignInTime': model.lastSignInTime!.toIso8601String(),
      'phoneNumber': model.phoneNumber ?? '',
      'photoURL': model.photoURL ?? '',
      'providerData': model.providerData==null ? []: model.providerData!.map((userInfo) => userInfo).toList(),
      'refreshToken': model.refreshToken,
      'tenantId': model.tenantId ?? '',
      'sysDefaultTheme': themeModeToString(model.sysDefaultTheme),
      'userColorScheme': colorSchemeToString(model.userColorScheme),
    };
  }

  static String themeModeToString(ThemeMode? themeMode) {
    return themeMode == ThemeMode.dark ? 'ThemeMode.dark' : 'ThemeMode.light';
  }

  static ThemeMode? _stringToThemeMode(String themeModeString) {
    switch (themeModeString) {
      case 'ThemeMode.light': return ThemeMode.light;
      case 'ThemeMode.dark': return ThemeMode.dark;
      default: return null;
    }
  }

  static String colorSchemeToString(ColorScheme? colorScheme) {
    return colorScheme?.brightness == Brightness.dark ? 'ColorScheme.dark' : 'ColorScheme.light';
  }

  static ColorScheme? _stringToColorScheme(String colorSchemeString) {
    switch (colorSchemeString) {
      case 'ColorScheme.dark': return const ColorScheme.dark();
      case 'ColorScheme.light': return const ColorScheme.light();
      default: return null;
    }
  }

  static String serialize(UserDetails model) => jsonEncode(UserDetails.toMap(model));
  static UserDetails deserialize(String json) => UserDetails.fromJson(jsonDecode(json));

  @override
  String toString() {
    return 'UserDetails{uid: $uid, displayName: $displayName, email: $email, emailVerified: $emailVerified, isAnonymous: $isAnonymous, creationTime: $creationTime, lastSignInTime: $lastSignInTime, phoneNumber: $phoneNumber, photoURL: $photoURL, providerData: $providerData, refreshToken: $refreshToken, tenantId: $tenantId, sysDefaultTheme: $sysDefaultTheme, userColorScheme: $userColorScheme}';
  }
}