import 'dart:io';
import 'package:device_info/device_info.dart';

class DeviceInfoService {
  String get osType => Platform.operatingSystem;
  Future<String?> get osVersion async {
    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      return iosInfo.systemVersion;
    }
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      return "${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})";
    }
    return null;
  }

  bool get isIOS => Platform.isIOS;
  Future<bool> get isIOS13 async {
    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      if (iosInfo.systemVersion.startsWith('13')) {
        return true;
      }
    }
    return false;
  }
}
