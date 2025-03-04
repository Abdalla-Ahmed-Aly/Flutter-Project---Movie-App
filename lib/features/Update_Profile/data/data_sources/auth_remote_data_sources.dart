import 'package:movieapp/features/Update_Profile/data/models/UpdateDataRequest.dart';
import 'package:movieapp/features/Update_Profile/data/models/update_data_request.dart';

abstract class AuthRemoteDataSources {
  Future<UpdateDataResponse> update(UpdateDataRequest updateDataRequest);

}