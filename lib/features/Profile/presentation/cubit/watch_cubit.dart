import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/error/exception.dart';
import 'package:movieapp/features/Profile/data/data_sources/auth_remote_api_data_sources.dart';
import 'package:movieapp/features/Profile/data/repositories/whtchListrepository.dart';
import 'package:movieapp/features/Profile/presentation/cubit/watchstate.dart';

class WatchCubit extends Cubit<AuthState> {
  WatchCubit() : super(AuthInitial());
  final Whtchlistrepository _authRepository =
      Whtchlistrepository(AuthRemoteApiDataSources());

  Future<void> getWatchList() async {
    try {
      emit(AuthLoading());
      final data = await _authRepository.getWatchList();
      emit(AuthSuccess(data));
    } on AppException catch (e) {
      emit(AuthError(e.message));
    }
  }

  Future<bool> deleteWatchList(int movieId) async {
    try {
      emit(Authloadingdelete());
      await _authRepository.deleteWatchList(movieId);
      emit(AuthSuccessdelete());
      return true;
    } on AppException catch (e) {
      emit(AuthErrordlete(e.message));
      return false;
    }
  }
}
