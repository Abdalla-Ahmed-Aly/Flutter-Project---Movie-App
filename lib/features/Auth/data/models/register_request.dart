class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final int avaterId;

  const RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.avaterId,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'phone': phone,
        'avaterId': avaterId,
      };
}
