class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  final List<int> movies;

  HistorySuccess(this.movies);
}

class HistoryFailure extends HistoryState {
  final String error;

  HistoryFailure(this.error);
}
