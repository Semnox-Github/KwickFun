// import  'package:flutter/foundation.dart';
// import  'package:flutter_riverpod/flutter_riverpod.dart';

// import  '../config_provider.dart';

// class ConfigViewModel extends ChangeNotifier {

  
//   static ChangeNotifierProvider<ConfigViewModel> provider =
//       ChangeNotifierProvider<ConfigViewModel>(
//     (ref) {
//       var config = ref.watch(ConfigStateProvider.stateNotifier);
//       var manager = ref.read(ConfigStateProvider.stateProvider).state;
//       return ConfigViewModel(config, manager.updateConfig);
//     },
//   );

//   ConfigViewModel(SemnoxConfig config, ValueChanged<SemnoxConfig> update)
//       // : _update = update,
//       //   _config = config 
//         {
//     _init();
//   }

//   // final SemnoxConfig _config;

//   // final ValueChanged<SemnoxConfig> _update;

//   _init() {
//     // initialzeServerConfigs(_config.serverConfig);
//   }

//   // void save() {
//   //   _update.call(
//   //     _config.copyWith(
//   //       serverConfig: getServerConfig(),
//   //     ),
//   //   );
//   // }

// }
