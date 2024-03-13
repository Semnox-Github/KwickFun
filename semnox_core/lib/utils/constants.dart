class SemnoxConstants {
  SemnoxConstants._();
  static String get lookupUrl => "/api/Lookups/LookupsContainer";
  static String get langauageContainerUrl =>
      "/api/Configuration/LanguageContainer";
  static String get translationUrl => "/api/Communication/MessageContainer";
  static String get remoteConnectionUrl => "/api/Common/RemoteConnectionCheck";
  static String get defaultContainerUrl =>
      "/api/Configuration/ParafaitDefaultContainer";
  static String get posMachineContainerUrl => "/api/POS/POSMachinesContainer";
  static String get siteContainerUrl => "/api/Organization/SiteContainer";
  static String get authenticateSystemUsersUrl =>
      "/api/Login/AuthenticateSystemUsers";
  static String get authenticateAppUsersUrl =>
      "/api/Login/AuthenticateUsersNew";
  static String get otpUrl => "/api/CommonServices/GenericOTP";
  static String get customersUrl => "/api/Customer/Customers";
  static String get customerLoginUrl => "/api/Customer/CustomerLogin";
  static String get accountSummaryUrl =>
      "/api/Customer/Account/AccountSummaryView";
  static String get gameMachineUrl => "/api/Game/Machines";
  static String get gameUrl => "/api/Game/Games";
  static String get gameprofileUrl => "/api/Game/GameProfiles";
  static String get gamePlaysUrl => "/api/Transaction/GamePlays";
  //replaced
  static String get userRoleUrl => "/api/HR/UserRoles";
  static String get userUrl => "/api/HR/Users";
  //to change
  static String get userContainerUrl => "/api/HR/UserContainer";
  //new
  static String get userRoleContainerUrl => "/api/HR/UserRoleContainer";
  static const Duration animationDuration = Duration(milliseconds: 250);

  static String get assetTypeUrl => "/api/Maintenance/AssetTypes";
  static String get assetGroupassetUrl => "/api/Maintenance/AssetGroupAssets";
  static String get assetGroupUrl => "/api/Maintenance/AssetGroups";
  static String get genericassetUrl => "/api/Maintenance/GenericAssets";
}
