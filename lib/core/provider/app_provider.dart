import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppProvider extends ChangeNotifier {
  PackageInfo? _packageInfo;
  PackageInfo? get deviceInfo {
    return _packageInfo;
  }

  Future<PackageInfo> getDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    notifyListeners();
    return _packageInfo!;
  }
}
