import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/machine_mac_address/mac_address_provider.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/network_configuration/bl/network_configuration_bl.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_configuration_provider.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_connectivity_provider.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_core/utils/message.dart';
import 'package:semnox_core/utils/utils.dart';

class NetworkConfigurationFormViewModel extends ChangeNotifier {
  static final provider =
      ChangeNotifierProvider.autoDispose<NetworkConfigurationFormViewModel>(
    (ref) {
      return NetworkConfigurationFormViewModel();
    },
  );

  NetworkConfigurationFormViewModel() {
    sslList?.add("https://");
    sslList?.add("http://");
    sslField.setInitialValue(sslList!.first);
    serverIpField.setInitialValue("");
    _init();
  }

  final BehaviorSubject<String> _ssId = BehaviorSubject.seeded("");
  ValueStream<String> get ssId => _ssId.stream;
  final BehaviorSubject<String> _deviceipAddress = BehaviorSubject.seeded("");
  ValueStream<String> get deviceipAddress => _deviceipAddress.stream;
  final BehaviorSubject<String> _macAddress = BehaviorSubject.seeded("");
  ValueStream<String> get macAddress => _macAddress.stream;

  final DataProvider<NetworkConfigurationDTO?> _conctionInfoProvider =
      DataProvider<NetworkConfigurationDTO?>();
  ValueStream<DataState<NetworkConfigurationDTO?>> get connectionInfoProvider =>
      _conctionInfoProvider.dataStream;

  late SemnoxTextFieldProperties serverIpField =
      SemnoxTextFieldProperties(hintText: "Enter Server API Url", validators: [
    (value) {
      if (value?.isEmpty ?? true) return "Server API Url is required";
      return null;
    }
  ]);

  late SemnoxTextFieldProperties portNoField =
      SemnoxTextFieldProperties(hintText: "No PortNo");

  late SemnoxTextFieldProperties subnetworkMaskField =
      SemnoxTextFieldProperties(hintText: "No SubNetwork Mask");

  NetworkConfigurationDTO? _networkConfigurationDTO;
  late BuildContext? buildContext;

  final DataProvider<bool> validatebutton = DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get validatebuttonStates =>
      validatebutton.dataStream;

  final DataProvider<bool> saveconfigbutton =
      DataProvider<bool>(initial: false);
  ValueStream<DataState<bool>> get saveconfigbuttonStates =>
      saveconfigbutton.dataStream;

  SemnoxDropdownProperties<String> sslField =
      SemnoxDropdownProperties<String>(items: []);

  List<String>? sslList = [];

  final formKey = GlobalKey<FormState>();
  int? index = 0;

  bool? isservervalid = false,
      isWebServerAccessible = false,
      isDbConnectionEstablished = false;

  bool? viewbuttonenabled = false;
  List<ServerReachablewithException?>? serverReachablewithException = [];

  _init() async {
    _networkConfigurationDTO = await _fetchLocalStorageNetworkConfiguration();
    _networkConfigurationDTO ??= await _builNetworkConfiguration();
    await _buildConfigurationForm(_networkConfigurationDTO);

    sslField = SemnoxDropdownProperties<String>(
        items: sslList!
            .map((e) =>
                DropdownMenuItem<String>(value: e, child: SemnoxText(text: e)))
            .toList(),
        enabled: true,
        validators: [
          (data) {
            if (data == null) {
              return "Select Any Site";
            }
            return null;
          }
        ]);

    if (sslList!.isNotEmpty) {
      if (_networkConfigurationDTO != null) {
        index = sslList?.indexWhere(
          (element) => _networkConfigurationDTO!.serverUrl!.contains(element),
        );
      }
      sslField.setInitialValue(sslList![index!]);
    }
  }

  Future<NetworkConfigurationDTO?> _builNetworkConfiguration() async {
    _networkConfigurationDTO = NetworkConfigurationDTO(
        ssId: await NetworkConnectivityProvider().getNetworkSSID(),
        deviceipAddress:
            await NetworkConnectivityProvider().getDeviceIpAddress(),
        serverUrl: sslField.value! +
            serverIpField.value
                .replaceAll("https://", "")
                .replaceAll("http://", ""),
        //https://parafaitdevaws1api1.parafait.com
        //https://parafaitdevaws1api1.parafait.com"https://parafaitposredesigndevapi.parafait.com", //https://smartfungigademo.parafait.com
        portNumber: portNoField.value,
        subNetworkMask: subnetworkMaskField.value);
    return _networkConfigurationDTO;
  }

  Future<void> _buildConfigurationForm(
      NetworkConfigurationDTO? networkConfigurationDTO) async {
    _conctionInfoProvider.updateData(_networkConfigurationDTO);
    if (_networkConfigurationDTO == null) return;
    _ssId.add(networkConfigurationDTO?.ssId ?? "");
    _deviceipAddress.add(networkConfigurationDTO?.deviceipAddress ?? "");
    _macAddress.add(await MacAddressProvider().getMacAddress());
    serverIpField.setInitialValue(networkConfigurationDTO?.serverUrl
            ?.replaceAll("https://", "")
            .replaceAll("http://", "") ??
        "");
  }

  Future<NetworkConfigurationDTO?>
      _fetchLocalStorageNetworkConfiguration() async {
    try {
      _networkConfigurationDTO =
          await NetworkConfigurationProvider().getNetworkConfiguration();
    } on NetworkConfigurationNotFoundException catch (e) {
      // _log?.error(
      //     "_getNetworkConfiguration",
      //     await getTranslationString(
      //         "Network Configuration Not Found Exception"),
      //     NetworkConfigurationNotFoundException());
      // SemnoxSnackbar.error(buildContext!, e.toString());
    }
    return _networkConfigurationDTO;
  }

  Future<void> clearserverurl() async {
    if (serverIpField.value.isEmpty) {
      serverIpField.setInitialValue("");
    } else {
      var result = await Utils().showWarning(
          buildContext!,
          TranslationProvider.getTranslationBykey(
              Messages.serverUrlClearDescription),
          Messages.serverUrlClear);
      if (result == true) {
        // Yes click
        await NetworkConfigurationProvider()
            .storeNetworkConfiguration(_networkConfigurationDTO);
        await ExecutionContextProvider().clearExecutionContext();
        serverIpField.setInitialValue("");
      }
    }
  }

  Future<bool> checkserverurlchanged(BuildContext context) async {
    var executionContextDTO =
        await ExecutionContextProvider().getExecutionContext();
    if (executionContextDTO?.apiUrl != null) {
      if (sslField.value! + serverIpField.value !=
          executionContextDTO?.apiUrl) {
        // ignore: use_build_context_synchronously
        var result = await Utils().showWarning(
            context,
            TranslationProvider.getTranslationBykey(
                Messages.serverUrlChangedDescription),
            Messages.serverUrlChanged);
        if (result == true) {
          // Yes click
          await NetworkConfigurationProvider()
              .storeNetworkConfiguration(_networkConfigurationDTO);
          await ExecutionContextProvider().clearExecutionContext();
          // ignore: use_build_context_synchronously
          await validateIpAddress(context);
        } else {
          return false;
        }
      }
    }
    return true;
  }

  Future<bool?> validateIpAddress(BuildContext context) async {
    ServerReachablewithException? serverreachable;
    validatebutton.startLoading();
    await _builNetworkConfiguration();
    await _buildConfigurationForm(_networkConfigurationDTO);
    String url = sslField.value! + serverIpField.value;
    var result = validator.url(url);
    if (result == true) {
      serverReachablewithException = [];
      serverReachablewithException?.add(ServerReachablewithException(
          entitytype: "Is Server Url Format Valid?",
          status: true,
          statusCode: null,
          exception: "null"));
      serverreachable = await NetworkConfigurationBL(_networkConfigurationDTO)
          .checkServerAddressisValid(checkDBConnection: false);
      if (serverreachable?.status == false) {
        serverReachablewithException?.add(ServerReachablewithException(
            entitytype: "Is Webserver Accessible?",
            status: false,
            statusCode: serverreachable?.statusCode,
            exception: serverreachable?.exception,
            stackTrace: serverreachable?.stackTrace));
        SemnoxSnackbar.error(buildContext!, "Webserver Not Accessible");
      } else {
        serverReachablewithException?.add(ServerReachablewithException(
            entitytype: "Is Webserver Accessible?",
            statusCode: null,
            status: true,
            exception: "null"));
      }
      if (serverreachable?.status == true) {
        serverreachable = await NetworkConfigurationBL(_networkConfigurationDTO)
            .checkServerAddressisValid(checkDBConnection: true);
        if (serverreachable?.status == false) {
          serverReachablewithException?.add(ServerReachablewithException(
              entitytype: "Is DB Connection Established?",
              status: false,
              statusCode: serverreachable?.statusCode,
              exception: serverreachable?.exception,
              stackTrace: serverreachable?.stackTrace));
          SemnoxSnackbar.error(buildContext!, "DB Connection Not Established");
        } else {
          serverReachablewithException?.add(ServerReachablewithException(
              entitytype: "Is DB Connection Established?",
              status: true,
              statusCode: null,
              exception: "null"));
        }
      } else {
        serverReachablewithException?.add(ServerReachablewithException(
            entitytype: "Is DB Connection Established ?",
            status: false,
            statusCode: null,
            exception: "null"));
      }

      if (serverreachable?.status == false) {
        viewbuttonenabled = true;
        notifyListeners();
        validatebutton.updateData(true);
        return false;
      }
      validatebutton.updateData(true);
      return true;
    } else {
      serverReachablewithException = [];
      serverReachablewithException?.add(ServerReachablewithException(
          entitytype: "Is Server Url Format Valid ?",
          status: false,
          statusCode: null,
          exception: "Server Url Format Not Valid"));
      serverReachablewithException?.add(ServerReachablewithException(
          entitytype: "Is WebServer Accessible ?",
          status: false,
          statusCode: null,
          exception: "null"));
      serverReachablewithException?.add(ServerReachablewithException(
          entitytype: "Is DB Connection Established ?",
          status: false,
          statusCode: null,
          exception: "null"));
      SemnoxSnackbar.error(buildContext!, "Please Enter Valid server Url");
      viewbuttonenabled = true;
      notifyListeners();
      validatebutton.updateData(true);
      return false;
    }
  }

  // bool isURl(String url) {
  //   return RegExp(
  //           r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?")
  //       .hasMatch(url);
  // }

  saveNetworkConfiguraton() async {
    NetworkConfigurationProvider()
        .storeNetworkConfiguration(_networkConfigurationDTO);
  }

  NetworkConfigurationDTO? getnetworkconfigurationDTO() {
    return _networkConfigurationDTO;
  }
}

class ServerReachablewithException {
  String? entitytype;
  bool? status;
  Object? exception;
  StackTrace? stackTrace;
  String? errortype;
  int? statusCode;

  ServerReachablewithException(
      {this.entitytype,
      this.status,
      this.exception,
      this.stackTrace,
      this.statusCode});
}
