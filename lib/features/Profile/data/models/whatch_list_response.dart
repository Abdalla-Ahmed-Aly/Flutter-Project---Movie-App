import 'whatch_list_response_data.dart';

class WhatchListResponse {
  final String? message;
  final List<WhatchListResponseData>? data;

  const WhatchListResponse({this.message, this.data});

  factory WhatchListResponse.fromJson(Map<String, dynamic> json) {
    return WhatchListResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WhatchListResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
