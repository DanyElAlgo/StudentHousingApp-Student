class CredentialsDto {
  const CredentialsDto({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  factory CredentialsDto.fromJson(Map<String, dynamic> json) {
    return CredentialsDto(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}
