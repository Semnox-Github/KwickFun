// import  'package:flutter_riverpod/flutter_riverpod.dart';

// class ConfigStateProvider extends StateNotifier<SemnoxConfig> {
//   static final stateProvider = 
//    StateProvider<ConfigStateProvider>((ref) {
//     return ConfigStateProvider();
//   });
//   static final stateNotifier = 
//    StateNotifierProvider<ConfigStateProvider,SemnoxConfig>((ref) {
//     return ref.read(stateProvider).state;
//   });

//   ConfigStateProvider()
//       : super(SemnoxConfig(serverConfig: SemnoxServerConfig())) {
//     _initialize();
//   }

//   final _storageKey = "semnox_config";

//   void _initialize() {
//     state = _getFromStorage();
//   }

//   void updateConfig(SemnoxConfig config) {

//     _storeConfig(config);
//     _initialize();
//   }

//   SemnoxConfig get config => state;


//   ///
//   ///Storage Related Methods
//   ///
//   ///
//   SemnoxConfig _getFromStorage() {
//     String? data = LocalStorage().getValue(_storageKey);
//     if (data == null || (data.isEmpty))
//       return SemnoxConfig(serverConfig: SemnoxServerConfig());
//     return SemnoxConfig.fromJson(data);
//   }

//   void _storeConfig(SemnoxConfig config){
//     LocalStorage().save(_storageKey, config.toJson());
//   }
// }
