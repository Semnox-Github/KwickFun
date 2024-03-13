class NetworkConfigurationDTO {
  String? _ssId;
  String? _deviceipAddress;
  String? _portNumber;
  String? _serverUrl;
  String? _subNetworkMask;

  NetworkConfigurationDTO(
      {String? ssId,
      String? deviceipAddress,
      String? portNumber,
      String? serverUrl,
      String? subNetworkMask}) {
    _ssId = ssId;
    _deviceipAddress = deviceipAddress;
    _portNumber = portNumber;
    _serverUrl = serverUrl;
    _subNetworkMask = subNetworkMask;
  }

  String? get ssId => _ssId;
  String? get deviceipAddress => _deviceipAddress;
  String? get portNumber => _portNumber;
  String? get serverUrl => _serverUrl;
  String? get subNetworkMask => _subNetworkMask;

  factory NetworkConfigurationDTO.fromJson(Map<String, dynamic> json) =>
      NetworkConfigurationDTO(
          ssId: json["SSId"],
          deviceipAddress: json["DeviceIpAddress"],
          portNumber: json["PortNumber"],
          serverUrl: json["ServerUrl"],
          subNetworkMask: json["SubNetworkMask"]);

  Map<String, dynamic> toMap() => {
        "SSId": ssId,
        "DeviceIpAddress": deviceipAddress,
        "PortNumber": portNumber,
        "ServerUrl": serverUrl,
        "SubNetworkMask": subNetworkMask,
      };
}
