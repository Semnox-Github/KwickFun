// import  'package:semnox_core/modules/config/model/config.dart';
// import  'package:semnox_core/modules/config/view/widget/settings_list_tile.dart';

// abstract class ServerConfigsHelper {
//   ConfigListTileProperties ipAddressField =
//       ConfigListTileProperties(label: "IP Address", value: "192.168.1.4");
//   ConfigListTileProperties portNoField =
//       ConfigListTileProperties(label: "Port Number", value: "");
//   ConfigListTileProperties ipAddressMaskField =
//       ConfigListTileProperties(label: "IP Address Mask", value: "");

//   late SemnoxServerConfig _initialConfig;

//   void initialzeServerConfigs(SemnoxServerConfig serverConfig) {


//     _initialConfig = serverConfig;
    
//     ipAddressField = ConfigListTileProperties(
//       label: "IP Address",
//       value: _initialConfig.ipAddress ?? "",
//     );
    
//     portNoField = ConfigListTileProperties(
//       label: "Port Number",
//       value: serverConfig.portNo ?? "",
//     );
    
//     ipAddressMaskField = ConfigListTileProperties(
//       label: "IP Address Mask",
//       value: serverConfig.ipAddressMask ?? "",
//     );
//   }

//   SemnoxServerConfig getServerConfig() {
//     return _initialConfig.copyWith(
//       ipAddress: ipAddressField.inputFieldProperties.value,
//       portNo: portNoField.inputFieldProperties.value,
//       ipAddressMask: ipAddressMaskField.inputFieldProperties.value,
//     );
//   }

//   // String get network;
// }
