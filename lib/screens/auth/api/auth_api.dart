import 'package:kms_bpkp_mobile/apis/request.dart';
import 'package:kms_bpkp_mobile/apis/response.dart';
import 'package:kms_bpkp_mobile/apis/services.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';

class AuthService implements AuthApiService {
  @override
  Future<TokenModel> getAccessToken(Map req) async {
    var result = await handleResponse(await postRequest(loginEp, req, ""));
    return TokenModel.fromJson(result);
  }
}
