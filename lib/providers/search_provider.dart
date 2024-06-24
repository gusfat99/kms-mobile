import 'package:flutter/foundation.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/page_search_model.dart';
import 'package:kms_bpkp_mobile/screens/pencarian/api/pencarian_api.dart';

class SearchProvider extends ChangeNotifier {
  final SearchService _searchService = SearchService();
  final int _limit = 15;
  int _page = 1;
  bool hasMore = true;
  String _searchKey = "";
  List<PengetahuanResult> pengetahuanResults = [];

  Future fetchSearchValue(String keySearch) async {
    try {
      _searchKey = keySearch;
      PageSearchKnowledgeModel? response = await _searchService
          .getSearchKnowledgeData(_page, _limit, _searchKey);

      if (response!.pengetahuanModel.pengetahuanResults.length < _limit) {
        hasMore = false;
      }
      pengetahuanResults.addAll(response!.pengetahuanModel.pengetahuanResults);
      _page++;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future refresh(String keySearch) async {
    _page = 1;
    pengetahuanResults = [];
    hasMore = true;
    _searchKey = keySearch;
    await fetchSearchValue(_searchKey);
    notifyListeners();
  }
}
