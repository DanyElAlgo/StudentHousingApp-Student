abstract final class AppConfig {
  AppConfig._();

  static const String apiBaseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:5065',
  );

  static const String googleWebClientId =
      '20499997116-uupm509odq8rni0dhf75qm1jb183qva8.apps.googleusercontent.com';

  static const String studentRole = 'Student';
}
