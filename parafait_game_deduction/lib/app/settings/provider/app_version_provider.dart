import  'package:flutter_riverpod/flutter_riverpod.dart';
import  'package:package_info_plus/package_info_plus.dart';

final appVersionProvider = FutureProvider<AppVersion>((ref) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  return AppVersion(
    appName: appName,
    packageName: packageName,
    version: version,
    buildNumber: buildNumber,
  );
});

class AppVersion {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  AppVersion(
      {required this.appName,
      required this.packageName,
      required this.version,
      required this.buildNumber});
}
