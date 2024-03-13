enum Flavor {
  development,
  production,
}

class F {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'Kwickfun Dev';
      case Flavor.production:
        return 'Kwickfun';
      default:
        return 'title';
    }
  }
}
