import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/error/exception.dart';
import 'package:movieapp/features/Update_Profile/data/data_sources/auth_remote_api_data_sources.dart';
import 'package:movieapp/features/Update_Profile/data/models/UpdateDataRequest.dart';
import 'package:movieapp/features/Update_Profile/data/repositories/update_repositry.dart';
import 'package:movieapp/features/Update_Profile/presentation/cubit/AuthState.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final UpdateRepositry _authRepository =
      UpdateRepositry(AuthRemoteApiDataSources());
  Future<void> updateData(UpdateDataRequest updateDataRequest) async {
    try {
      if (isClosed) return; // التحقق من إغلاق Cubit
      emit(AuthLoading());
      final updatedData = await _authRepository.updateData(updateDataRequest);
      if (isClosed) return; // التحقق من إغلاق Cubit
      emit(AuthUpdateSuccess(updatedData)); // حالة نجاح التحديث
    } on AppException catch (e) {
      if (isClosed) return; // التحقق من إغلاق Cubit
      emit(AuthError(e.message)); // حالة خطأ التحديث
    }
  }
}
