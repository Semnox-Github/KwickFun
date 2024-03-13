import 'package:flutter_modular/flutter_modular.dart';

class NavigationService{
  Future<T?> push<T>(String routeName,{Map<String,dynamic> args = const {}}){
    return Modular.to.pushNamed(routeName,arguments: args);
  }
}