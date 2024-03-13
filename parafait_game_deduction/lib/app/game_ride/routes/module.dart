import 'package:flutter_modular/flutter_modular.dart';
import '../view/pages/semnox_purchases_screen.dart';
import '../view/pages/semnox_ride_entry_screen.dart';

class GameModule extends Module {
  static String purchaseHistory = "purchaseHistory";
  static String gameHistory = "gameHistory";
  static String cardNoKey = "cardNo";
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (context, args) => SemnoxRideEntryScreen(),
        ),
        ChildRoute("/$purchaseHistory",
            child: (context, args) => SemnoxPurchasesScreen(
                cardNo: args.queryParams[cardNoKey] ?? "",
                accountsummaryDTO: args.data)),
        ChildRoute(
          "/$gameHistory",
          child: (context, args) => SemnoxGameHistoryScreen(
         cardNo: args.queryParams[cardNoKey] ?? "",
                accountsummaryDTO: args.data)),
        
      ];
}
