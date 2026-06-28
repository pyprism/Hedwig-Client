/// Build-time constants injected via --dart-define.
///
/// Usage:
///   flutter run  --dart-define=FLAVOR=dev  --dart-define=DEFAULT_API_URL=https://dev.example.com
///   flutter build web --release --dart-define=FLAVOR=prod
abstract final class EnvConfig {
  /// Build flavor: dev | staging | prod
  static const String flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'prod');

  /// Optional default base URL shown in the login field.
  /// The user can override it at runtime; this is only a convenience pre-fill.
  static const String defaultApiUrl =
      String.fromEnvironment('DEFAULT_API_URL', defaultValue: '');

  /// Whether to show the debug banner in MaterialApp.
  static const bool showDebugBanner = flavor != 'prod';

  static bool get isDev => flavor == 'dev';
  static bool get isStaging => flavor == 'staging';
  static bool get isProd => flavor == 'prod';
}
