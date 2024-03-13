import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/bl/parafait_default_view_bl.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/model/parafait_default_values_dto.dart';

class DefaultConfigProvider {
  static final Map<String, ParafaitDefaultValueDto> _defaultConfig = {};
  int get length => _length;
  int _length = 0;
  ExecutionContextDTO? _executionContextDTO;

  DefaultConfigProvider({ExecutionContextDTO? executionContextDTO}) {
    _executionContextDTO = executionContextDTO;
  }

  initialize() async {
    var defaultconfig = await ParafaitDefaultViewListBL(_executionContextDTO)
        .getParafaitDefault();
    if (defaultconfig != null) {
      _loadConfigs(defaultconfig);
    }
  }

  ///
  ///All Possible Keys for `defaultConfigKey` are Documented in `DefaultConfigKey` class. Use Those keys to get Values.
  ///
  static String? getConfigFor(String defaultConfigKey) {
    return (_defaultConfig[defaultConfigKey])?.value;
  }

  ///
  ///Load Values to the Config. Use This Function to Populating Configs.
  ///

  void _loadConfigs(List<ParafaitDefaultValueDto> defaultConfigs) {
    for (var config in defaultConfigs) {
      _defaultConfig[config.name!] = config;
    }
    _length = _defaultConfig.length;
  }

  Map<String, dynamic> toMap() {
    return {
      "configs": _defaultConfig.values.map((e) => e.toMap()).toList(),
    };
  }
}
