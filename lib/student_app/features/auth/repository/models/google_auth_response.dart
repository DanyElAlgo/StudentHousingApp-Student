import 'credentials_dto.dart';

class GoogleAuthResponse {
  const GoogleAuthResponse({required this.isNewUser, this.credentials});

  final bool isNewUser;
  final CredentialsDto? credentials;

  factory GoogleAuthResponse.fromJson(Map<String, dynamic> json) {
    final dynamic creds = json['credentials'];
    if (creds is Map) {
      return GoogleAuthResponse(
        isNewUser: json['isNewUser'] as bool? ?? false,
        credentials: CredentialsDto.fromJson(Map<String, dynamic>.from(creds)),
      );
    }
    // Fallback: a bare token pair means an existing (returning) user.
    if (json.containsKey('accessToken')) {
      return GoogleAuthResponse(
        isNewUser: false,
        credentials: CredentialsDto.fromJson(json),
      );
    }
    return GoogleAuthResponse(isNewUser: json['isNewUser'] as bool? ?? true);
  }
}
