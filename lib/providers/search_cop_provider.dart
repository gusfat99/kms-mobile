import 'package:flutter/foundation.dart';
import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/models/page_search_cop_model.dart';
import 'package:kms_bpkp_mobile/screens/pencarian/api/pencarian_cop_api.dart';

class SearchCopProvider extends ChangeNotifier {
  final SearchCopService _searchService = SearchCopService();
  final int _limit = 15;
  int _page = 1;
  bool hasMore = true;
  String _searchKey = "";
  List<CopResult> copResults = [];

  Future fetchSearchValue(String keySearch) async {
    try {
      _searchKey = keySearch;
      PageSearchCopModel? response = await _searchService
          .getSearchCopData(_page, _limit, _searchKey);

      if (response!.copModel.copResults.length < _limit) {
        hasMore = false;
      }
      copResults.addAll(response!.copModel.copResults);
      _page++;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future refresh(String keySearch) async {
    _page = 1;
    copResults = [];
    hasMore = true;
    _searchKey = keySearch;
    await fetchSearchValue(_searchKey);
    notifyListeners();
  }
}
