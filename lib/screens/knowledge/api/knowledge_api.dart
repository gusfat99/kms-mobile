import 'dart:convert';

import 'package:kms_bpkp_mobile/apis/request.dart';
import 'package:kms_bpkp_mobile/apis/response.dart';
import 'package:kms_bpkp_mobile/apis/services.dart';
import 'package:kms_bpkp_mobile/models/api_feedback_model.dart';
import 'package:kms_bpkp_mobile/models/api_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_sub_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';
import 'package:kms_bpkp_mobile/models/page_berbagi_model.dart';
import 'package:kms_bpkp_mobile/models/page_knowledge_model.dart';
import 'package:nb_utils/nb_utils.dart';

class KnowledgeService implements KnowledgeApiService {
  @override
  Future<PageKnowledgeModel> getKnowledgeData(String selectedId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {};
    if (selectedId != "999") {
      apiParam = {"jenis_pengetahuan.id": selectedId};
    }
    //PENGETAHUAN
    var resultPengetahuan =
        await handleResponse(await getRequest(pengetahuanEp, apiParam, token!));

    //JENIS PENGETAHUAN
    var resultJenisPengetahuan = await handleResponse(
        await getRequest(pengetahuanJenisEp, apiParam, token!));
    //USER
    String? jUser = prefs.getString('profile');
    Map<String, dynamic> tokenMap = jsonDecode(jUser!) as Map<String, dynamic>;
    User user = User.fromJson(tokenMap);

    PageKnowledgeModel homeData = PageKnowledgeModel(
        pengetahuanModel: PengetahuanModel.fromJson(resultPengetahuan),
        jenisPengetahuanModel:
            JenisPengetahuanModel.fromJson(resultJenisPengetahuan),
        user: user);

    return homeData;
  }

  @override
  Future<PengetahuanModel> getPengetahuan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {};
    var result =
        await handleResponse(await getRequest(pengetahuanEp, apiParam, token!));
    return PengetahuanModel.fromJson(result);
  }

  @override
  Future<PengetahuanModel> getPengetahuanByJenis(
      String jenisPengetahuan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {"jenis_pengetahuan.id": jenisPengetahuan};
    var result =
        await handleResponse(await getRequest(pengetahuanEp, apiParam, token!));
    return PengetahuanModel.fromJson(result);
  }

  @override
  Future<PageBerbagiModel> getJenisPengetahuan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {
      "\$is_disable_pagination": "true",
      "is_show.\$eq": "true"
    };
    var jenisPengetahuanResult = await handleResponse(
        await getRequest(pengetahuanJenisEp, apiParam, token!));
    var subJenisPengetahuanResult = await handleResponse(
        await getRequest(pengetahuanSubJenisEp, apiParam, token!));
    return PageBerbagiModel(
        jenisPengetahuanModel:
            JenisPengetahuanModel.fromJson(jenisPengetahuanResult),
        subJenisPengetahuanModel:
            SubJenisPengetahuanModel.fromJson(subJenisPengetahuanResult));
  }

  @override
  Future<PengetahuanModel> getPengetahuanById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {"\$include": "all", "id": id.toString()};
    var result =
        await handleResponse(await getRequest(pengetahuanEp, apiParam, token!));

    return PengetahuanModel.fromJson(result);
  }

  @override
  Future<PageKnowledgeDetailModel> getPengetahuanDetail(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParamPengetahuan = {
      "\$include": "all",
      "id": id.toString()
    };

    var result = await handleResponse(
        await getRequest(pengetahuanEp, apiParamPengetahuan, token!));
    var resultFeedback = await handleResponse(
        await getRequest('$komentarEp?pengetahuan.id.\$eq=$id', null, token!));

    return PageKnowledgeDetailModel(
        pengetahuanModel: PengetahuanModel.fromJson(result),
        feedbackModel: FeedbackModel.fromJson(resultFeedback));
  }

  @override
  Future<Object>? likePostPengetahuan(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    var result = await handleResponse(
        await postRequest('$pengetahuanEp/$id/like', {}, token!));
    return result;
  }

  @override
  Future<Object>? dislikePostPengetahuan(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var result = await handleResponse(
        await postRequest('$pengetahuanEp/$id/dislike', {}, token!));
    return result;
  }
}
