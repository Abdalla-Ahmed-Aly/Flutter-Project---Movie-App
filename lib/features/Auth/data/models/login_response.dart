class LoginResponse {
  final String token;
  final String message;

  LoginResponse({
    required this.token,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['data'],
      message: json['message'],
    );
  }
}
