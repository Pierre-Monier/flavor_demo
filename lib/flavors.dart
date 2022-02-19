enum Flavor {
  DEVELOPMENT,
  STAGING,
  PRODUCTION,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'Development Flavor';
      case Flavor.STAGING:
        return 'Staging App';
      case Flavor.PRODUCTION:
        return 'Production App';
      default:
        return 'title';
    }
  }

  static String get memeUrl {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return "https://media.giphy.com/media/s9ijJ0AI4JKko/giphy.gif";
      case Flavor.STAGING:
        return "https://media.giphy.com/media/XknChYwfPnp04/giphy.gif";
      case Flavor.PRODUCTION:
        return "https://media.giphy.com/media/zrCSvFfl2fP7W/giphy.gif";
      default:
        throw Exception("Unknown flavor for memeUri");
    }
  }
}
