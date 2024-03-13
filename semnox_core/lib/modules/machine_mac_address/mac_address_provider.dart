import 'package:semnox_core/utils/storage_service/local_storage.dart';
import 'package:uuid/uuid.dart';

class MacAddressProvider {
  final LocalStorage _localStorage = LocalStorage();

  final String _macAddressStorageKey = "MAC-Address";
  // ignore: non_constant_identifier_names
  int? APP_ID_DEFAULT_SIZE = 13;

  ///
  ///
  /// if already generated returns the existing  macAddress  or else generates new one and returns.
  ///
  ///

  Future<String> getMacAddress() async {
    String? macAddress = _getExistingMacAddress();
    if (macAddress != null) return macAddress;
    String newMacAddress = _generateMacAddress();
    return newMacAddress;
  }

  String _generateMacAddress() {
    // String newMacAddress = Random().nextInt(999999).toRadixString(16);
    var uuid = const Uuid();
    String newMacAddress = uuid.v4().substring(0,
        APP_ID_DEFAULT_SIZE); // Generate a v4 (random) id // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'
    _localStorage.save(_macAddressStorageKey, newMacAddress);
    return newMacAddress;
  }

  String? _getExistingMacAddress() {
    return _localStorage.get(
      _macAddressStorageKey,
    );
  }
}
