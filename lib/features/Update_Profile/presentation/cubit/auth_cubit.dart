import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/error/exception.dart';
import 'package:movieapp/features/Update_Profile/data/data_sources/auth_remote_api_data_sources.dart';
import 'package:movieapp/features/Update_Profile/data/models/UpdateDataRequest.dart';
import 'package:movieapp/features/Update_Profile/data/repositories/update_repositry.dart';
import 'package:movieapp/features/Update_Profile/presentation/cubit/AuthState.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferencekeys.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferences.dart';

class UpdateAuthCubit extends Cubit<UpdateAuthState> {
  UpdateAuthCubit() : super(UpdateAuthInitial());

  final UpdateRepositry _authRepository =
      UpdateRepositry(AuthRemoteApiDataSources());
  Future<void> updateData(UpdateDataRequest updateDataRequest) async {
    try {
      if (isClosed) return;
      emit(UpdateAuthLoading());
      final updatedData = await _authRepository.updateData(updateDataRequest);
      if (isClosed) return;
      emit(UpdateAuthUpdateSuccess(updatedData));
    } on AppException catch (e) {
      if (isClosed) return;
      emit(UpdateAuthError(e.message));
    }
  }

  Future<void> delete() async {
    try {
      if (isClosed) return;
      emit(UpdateAuthLoading());
      final updatedData = await _authRepository.delet();
      await LocalStorageServices.setString(LocalStorageKeys.authToken, '');

      if (isClosed) return;
      emit(UpdateAuthdeletSuccess());
    } on AppException catch (e) {
      if (isClosed) return;
      emit(UpdateAuthError(e.message));
    }
  }
}
