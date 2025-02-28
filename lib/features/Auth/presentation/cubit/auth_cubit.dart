import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/error/exception.dart';
import 'package:movieapp/features/Auth/data/data_sources/auth_remote_api_data_sources.dart';
import 'package:movieapp/features/Auth/data/models/data.dart';
import 'package:movieapp/features/Auth/data/models/register_request.dart';
import 'package:movieapp/features/Auth/data/repositories/auth_repository.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthRepository _authRepository =
      AuthRepository(AuthRemoteApiDataSources());
  Future<Data> register(RegisterRequest register_request) async {
    try {
      emit(AuthLoading());
      final userData = await _authRepository.register(register_request);
      emit(AuthSuccess(userData));
      return userData;
    } on AppException catch (e) {
      emit(AuthError(e.message));
      throw e;
    }
  }
}
