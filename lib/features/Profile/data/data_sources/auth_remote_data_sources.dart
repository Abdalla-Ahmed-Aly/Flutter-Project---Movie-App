import 'package:movieapp/features/Profile/data/models/whatch_list_response.dart';

abstract class AuthRemoteDataSources {
  Future<WhatchListResponse> getWatchList();
  Future<void> deleteWatchList(int Movie_id);
}
