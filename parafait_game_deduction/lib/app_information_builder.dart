import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/machine_mac_address/mac_address_provider.dart';
import 'package:semnox_core/utils/storage_service/storage_service.dart';

class AppInformationBuilder {
  static String get _systemuserName => "systemuserName";
  static String get _systemPassword => "systemPassword";
  Future<AppInformationDTO?> buildAppInformationFromPackage() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String? systemUserName = LocalStorage().get(_systemuserName);
    String? systemUserPassword = LocalStorage().get(_systemPassword);
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    return AppInformationDTO(
        appName: appName,
        buildNumber: buildNumber,
        releaseNumber: "",
        isOfflineEnabled: true,
        systemUsername: systemUserName,
        systemPassword: systemUserPassword,
        macAddress: await MacAddressProvider().getMacAddress(),
        inWebMode: kIsWeb,
        packageName: packageName,
        version: version);
  }
}
