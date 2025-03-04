import 'package:movieapp/features/Auth/data/models/data.dart';

class GetDataResponse {
  String? message;
  Data? data;

  GetDataResponse({this.message, this.data});

  factory GetDataResponse.fromJson(Map<String, dynamic> json) {
    return GetDataResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
