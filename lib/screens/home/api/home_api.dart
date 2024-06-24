import 'dart:convert';

import 'package:kms_bpkp_mobile/apis/request.dart';
import 'package:kms_bpkp_mobile/apis/response.dart';
import 'package:kms_bpkp_mobile/apis/services.dart';
import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_slider_model.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';
import 'package:kms_bpkp_mobile/models/page_home_model.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeService implements HomeApiService {
  @override
  Future<PageHomeModel> getHomeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {};
    //PENGETAHUAN
    var resultPengetahuan =
        await handleResponse(await getRequest(pengetahuanEp, apiParam, token!));

    //SLIDER
    var resultSlider =
        await handleResponse(await getRequest(sliderEp, apiParam, token));
    //COP
    var resultCop =
        await handleResponse(await getRequest(copEp, apiParam, token));

    //USER
    String? jUser = prefs.getString('profile');
    Map<String, dynamic> tokenMap = jsonDecode(jUser!) as Map<String, dynamic>;
    User user = User.fromJson(tokenMap);

    //NOTIFICATION COUNTER
    int notifCounter = 0; // TODO
    PageHomeModel homeData = PageHomeModel(
        pengetahuanModel: PengetahuanModel.fromJson(resultPengetahuan),
        sliderModel: List<SliderModel>.from(
            resultSlider.map((x) => SliderModel.fromJson(x))),
        copModel: CopModel.fromJson(resultCop),
        user: user,
        notificationCounter: notifCounter);

    return homeData;
  }
}
