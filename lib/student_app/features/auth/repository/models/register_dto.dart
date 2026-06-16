import '../../../../core/config/app_config.dart';

class RegisterDto {
  const RegisterDto({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.nationality,
    required this.gender,
    required this.birthDate,
    this.imageUrl = '',
    this.role = AppConfig.studentRole,
  });

  final String email;
  final String password;
  final String role;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String nationality;
  final String gender;
  final String imageUrl;

  final String birthDate;

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'role': role,
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'nationality': nationality,
    'gender': gender,
    'imageUrl': imageUrl,
    'birthDate': birthDate,
  };
}
