
class UpdateDataResponse {
  final String? message;

  const UpdateDataResponse({this.message});

  factory UpdateDataResponse.fromJson(Map<String, dynamic> json) {
    return UpdateDataResponse(
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
