import 'dart:convert';

String? decodeJwtSub(String? token) {
  if (token == null || token.isEmpty) return null;

  final parts = token.split('.');
  if (parts.length != 3) return null;

  try {
    final normalized = base64Url.normalize(parts[1]);
    final payload = utf8.decode(base64Url.decode(normalized));
    final decoded = jsonDecode(payload);
    if (decoded is! Map) return null;

    final dynamic sub =
        decoded['sub'] ??
        decoded['nameid'] ??
        decoded['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
    final value = sub?.toString();
    return (value == null || value.isEmpty) ? null : value;
  } catch (_) {
    return null;
  }
}
