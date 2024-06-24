import 'package:kms_bpkp_mobile/apis/request.dart';
import 'package:kms_bpkp_mobile/apis/response.dart';
import 'package:kms_bpkp_mobile/apis/services.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/page_search_model.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchService implements SearchKnowledgeApiService {
  @override
  Future<PageSearchKnowledgeModel>? getSearchKnowledgeData(
      int page, int limit, String searchKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {"levenshtein.keyword.\$eq": searchKey};
    //PENCARIAN PENGETAHUAN
    var resultSearchPengetahuan = await handleResponse(
        await getRequest(searchPengetahuanEp, apiParam, token!));

    PageSearchKnowledgeModel searchData = PageSearchKnowledgeModel(
        pengetahuanModel: PengetahuanModel.fromJson(resultSearchPengetahuan));

    return searchData;
  }
}
