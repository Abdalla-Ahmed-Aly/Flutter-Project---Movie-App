class AddToFavouriteResponse {
  final String message;
  final Map<String, dynamic> data;

  AddToFavouriteResponse({
    required this.message,
    required this.data,
  });

  factory AddToFavouriteResponse.fromJson(Map<String, dynamic> json) {
    return AddToFavouriteResponse(
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>,
    );
  }
}
