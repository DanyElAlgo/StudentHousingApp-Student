class UserProfile {
  const UserProfile({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.nationality,
    required this.gender,
    required this.imageUrl,
    required this.birthdate,
  });

  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String nationality;
  final String gender;
  final String imageUrl;

  final String birthdate;

  String get fullName => '$firstName $lastName'.trim();

  DateTime? get birthDateValue => _parseDate(birthdate);

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: (json['email'] ?? '').toString(),
      firstName: (json['firstName'] ?? '').toString(),
      lastName: (json['lastName'] ?? '').toString(),
      phoneNumber: (json['phoneNumber'] ?? '').toString(),
      nationality: (json['nationality'] ?? '').toString(),
      gender: (json['gender'] ?? '').toString(),
      imageUrl: (json['imageUrl'] ?? '').toString(),
      birthdate: (json['birthdate'] ?? '').toString(),
    );
  }
}

DateTime? _parseDate(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return null;
  return DateTime.tryParse(trimmed);
}
