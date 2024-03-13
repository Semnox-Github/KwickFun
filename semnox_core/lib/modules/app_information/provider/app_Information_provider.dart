import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';

class AppInformationProvider {
  AppInformationProvider._internal();
  static final _singleton = AppInformationProvider._internal();
  AppInformationDTO? _appInformationDTO;

  factory AppInformationProvider() {
    return _singleton;
  }

  buildAppInformation(appInformationDTO) async {
    _appInformationDTO = appInformationDTO;
  }

  Future<AppInformationDTO?> getAppInformation() async {
    return _appInformationDTO!;
  }

  Future<void> clearAppInformationDTO() async {
    _appInformationDTO = null;
  }
}
