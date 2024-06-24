import 'package:kms_bpkp_mobile/apis/request.dart';
import 'package:kms_bpkp_mobile/apis/response.dart';
import 'package:kms_bpkp_mobile/apis/services.dart';
import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/models/page_search_cop_model.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchCopService implements SearchCopApiService {
  @override
  Future<PageSearchCopModel>? getSearchCopData(
      int page, int limit, String searchKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {"levenshtein.keyword.\$eq": searchKey};
    //PENCARIAN PENGETAHUAN
    var resultSearchCop =
        await handleResponse(await getRequest(searchCopEp, apiParam, token!));

    PageSearchCopModel searchData = PageSearchCopModel(
        copModel: CopModel.fromJson(resultSearchCop));

    return searchData;
  }
}
