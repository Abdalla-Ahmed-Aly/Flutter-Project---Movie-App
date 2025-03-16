import 'package:bloc/bloc.dart';
import '../../../data/data_sources/FirebaseUtils.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  // دالة لتحميل قائمة الـ movieIds
  Future<void> loadMovies() async {
    emit(HistoryLoading()); // تعيين حالة التحميل

    try {
      List<int> movies = await FirebaseUtils.getMoviesIDs();
      emit(HistorySuccess(movies)); // تعيين حالة النجاح مع قائمة الـ movieIds
    } catch (e) {
      emit(HistoryFailure(
          "Failed to load movies: $e")); // تعيين حالة الفشل مع رسالة الخطأ
    }
  }

  // دالة لإضافة movieId إلى Firebase
  Future<void> addMovieID(int movieId) async {
    try {
      await FirebaseUtils.addMovieID(movieId);
      loadMovies(); // بعد إضافة الـ movieId بنجاح، نقوم بتحميل الأفلام مرة أخرى
    } catch (e) {
      emit(HistoryFailure(
          "Failed to add movie: $e")); // تعيين حالة الفشل إذا حدث خطأ
    }
  }

  Future<void> removeMovieID(int movieId) async {
    try {
      await FirebaseUtils.removeMovieID(movieId);

      loadMovies(); // نقوم بتحميل الأفلام المحدثة من Firebase
    } catch (e) {
      emit(HistoryFailure("Failed to remove movie: $e"));
    }
  }
  /*
    Future<void> removeMovieID(int movieId) async {
    try {
      await FirebaseUtils.removeMovieID(movieId);

       final currentState = state;
      if (currentState is HistorySuccess) {
        List<int> updatedMovies = List.from(currentState.movies);
        updatedMovies.remove(movieId);

        emit(HistorySuccess(updatedMovies));
      }
    } catch (e) {
      emit(HistoryFailure("Failed to remove movie: $e"));
    }
  }
   */
}
