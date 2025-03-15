class ResetPasswordResponse {
  final String? message;

  const ResetPasswordResponse({this.message});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      message: json['message'] as String?,
    );
  }
}
