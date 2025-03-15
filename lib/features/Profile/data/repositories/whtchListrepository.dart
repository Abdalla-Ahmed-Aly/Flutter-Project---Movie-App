import 'package:movieapp/features/Profile/data/data_sources/auth_remote_data_sources.dart';
import 'package:movieapp/features/Profile/data/models/whatch_list_response.dart';

class Whtchlistrepository {
  final AuthRemoteDataSources _remoteDataSources;

  Whtchlistrepository(this._remoteDataSources);
  Future<WhatchListResponse> getWatchList() async {
    final getDataResponse = await _remoteDataSources.getWatchList();
    return getDataResponse;
  }
  Future<void> deleteWatchList(int Movie_id) async {
    final deleteResponse = await _remoteDataSources.deleteWatchList(Movie_id);
    return deleteResponse;
  }
}
