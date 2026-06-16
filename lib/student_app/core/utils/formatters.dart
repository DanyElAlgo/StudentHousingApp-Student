import '../config/app_config.dart';

String formatPrice(num value) {
  final String fixed = value.toStringAsFixed(2);
  final int dotIndex = fixed.indexOf('.');
  final String integerPart = fixed.substring(0, dotIndex);
  final String decimalPart = fixed.substring(dotIndex + 1);

  final StringBuffer grouped = StringBuffer();
  for (int i = 0; i < integerPart.length; i++) {
    if (i != 0 && (integerPart.length - i) % 3 == 0) {
      grouped.write(',');
    }
    grouped.write(integerPart[i]);
  }

  return 'Bs. $grouped.$decimalPart';
}

String resolveImageUrl(String url) {
  final String trimmed = url.trim();
  if (trimmed.isEmpty) return trimmed;
  if (trimmed.startsWith('http://') ||
      trimmed.startsWith('https://') ||
      trimmed.startsWith('data:')) {
    return trimmed;
  }
  final String base = AppConfig.apiBaseUrl;
  final String path = trimmed.startsWith('/') ? trimmed : '/$trimmed';
  return '$base$path';
}
