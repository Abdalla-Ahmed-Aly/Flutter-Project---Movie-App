import 'package:movieapp/features/Update_Profile/data/data_sources/auth_remote_data_sources.dart';
import 'package:movieapp/features/Update_Profile/data/models/UpdateDataRequest.dart';
import 'package:movieapp/features/Update_Profile/data/models/update_data_request.dart';

class UpdateRepositry {
    final AuthRemoteDataSources _remoteDataSources;

  UpdateRepositry(this._remoteDataSources);
  Future<UpdateDataResponse> updateData(UpdateDataRequest updateDataRequest) async {
    final getDataResponse = await _remoteDataSources.update(updateDataRequest);
    return getDataResponse;
  }
}