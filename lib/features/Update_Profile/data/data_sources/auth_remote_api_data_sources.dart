import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movieapp/core/constans.dart';
import 'package:movieapp/features/Update_Profile/data/data_sources/auth_remote_data_sources.dart';
import 'package:movieapp/features/Update_Profile/data/models/UpdateDataRequest.dart';
import 'package:movieapp/features/Update_Profile/data/models/update_data_request.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferencekeys.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferences.dart';

class AuthRemoteApiDataSources implements AuthRemoteDataSources {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ConstansApi.BASE_URL,
    ),
  );

  AuthRemoteApiDataSources() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token =
            LocalStorageServices.getString(LocalStorageKeys.authToken);

        // طباعة التوكن للتحقق منه
        log("Token being sent: $token");

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        } else {
          log("⚠️ خطأ: التوكن غير متوفر!");
        }

        return handler.next(options);
      },
    ));
  }

  @override
  Future<UpdateDataResponse> update(UpdateDataRequest updateDataRequest) async {
    log("✅ update() function started");

    try {
      Map<String, dynamic> requestData = updateDataRequest.toJson();
      log("📤 Request Data: $requestData");

      final response = await _dio.patch(
        ConstansApi.UPDATE_PROFILE,
        data: requestData,
      );

      log("✅ Response received successfully!");
      log("📩 Response Data: ${response.data}");

      return UpdateDataResponse.fromJson(response.data);
    } on DioException catch (e) {
      log("❌ DioException caught: ${e.message}");

      String errorMessage = "حدث خطأ غير متوقع!";
      if (e.response != null) {
        log("📥 Response Data: ${e.response?.data}");
        log("⚠️ Status Code: ${e.response?.statusCode}");

        if (e.response?.statusCode == 400) {
          errorMessage = "⚠️ خطأ: ${e.response?.data['message']}";
        } else if (e.response?.statusCode == 401) {
          errorMessage = "⛔ غير مصرح لك!";
        } else if (e.response?.statusCode == 500) {
          errorMessage = "🚨 خطأ في السيرفر!";
        }
      }

      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      throw Exception();
    } catch (e) {
      log("❌ Unexpected Error: $e");
      Fluttertoast.showToast(
        msg: "⚠️ خطأ غير متوقع: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      throw Exception();
    }
  }

  @override
  Future<void> delete() async {
    await _dio.delete(
      ConstansApi.DELETE_PROFILE,
    );
  }
}
