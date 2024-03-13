enum Flavor {
  development,
  production,
}

class F {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'Semnox Parafait Dev';
      case Flavor.production:
        return 'Semnox Parafait';
      default:
        return 'title';
    }
  }
}
