import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kms_bpkp_mobile/apis/request.dart';
import 'package:kms_bpkp_mobile/apis/response.dart';
import 'package:kms_bpkp_mobile/apis/services.dart';
import 'package:kms_bpkp_mobile/models/api_cop_kategori.dart';
import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/models/api_feedback_model.dart';
import 'package:kms_bpkp_mobile/models/api_hashtag_model.dart';
// import 'package:kms_bpkp_mobile/models/api_hashtag_model.dart';
import 'package:kms_bpkp_mobile/models/api_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';
import 'package:kms_bpkp_mobile/models/page_cop_model.dart';
import 'package:kms_bpkp_mobile/models/page_detail_cop_model.dart';
import 'package:kms_bpkp_mobile/models/page_input_cop_model.dart';
import 'package:nb_utils/nb_utils.dart';

class CopService implements CopApiService {
  @override
  Future<PageInputCopModel> getInputCopData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {};

    //COP KATEGORI

    final String response = await rootBundle.loadString(copKategoriEpJson);
    final copKategori = await jsonDecode(response);

    //HASHTAG
    //HASHTAG
    var resultHashTag =
        await handleResponse(await getRequest(hashtagEp, apiParam, token!));

    var resultJenisPengetahuan = await handleResponse(
        await getRequest(pengetahuanJenisEp, apiParam, token));

    PageInputCopModel inputCopData = PageInputCopModel(
        copKategoriModel: CopKategoriModel.fromJson(copKategori),
        hashTagModel: HashTagModel.fromJson(resultHashTag),
        jenisPengetahuanModel:
            JenisPengetahuanModel.fromJson(resultJenisPengetahuan));

    return inputCopData;
  }

  @override
  Future<PageCopModel>? getCopData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {};

    //COP
    var resultCop =
        await handleResponse(await getRequest(copEp, apiParam, token!));

    //USER
    String? jUser = prefs.getString('profile');
    Map<String, dynamic> tokenMap = jsonDecode(jUser!) as Map<String, dynamic>;
    User user = User.fromJson(tokenMap);

    //===> COP KATEGORI
    final String response = await rootBundle.loadString(copKategoriEpJson);
    final copKategori = await jsonDecode(response);

    PageCopModel homeData = PageCopModel(
        copModel: CopModel.fromJson(resultCop),
        copKategoriModel: CopKategoriModel.fromJson(copKategori),
        user: user);

    return homeData;
  }

  @override
  Future<CopModel>? getCop() {
    // TODO: implement getCop
    throw UnimplementedError();
  }

  @override
  Future<Object>? submitNewCOP(Map pParam) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var submitResult =
        await handleResponse(await postRequest(copSubmit, pParam, token!));
    return submitResult;
  }

  Future<PageDetailCopModel> getFeedbackPanelCop(int copId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    // Map<String, dynamic> apiParam = {};

    var likeResult = await handleResponse(
        await getRequest('$likeEp?forum.id=$copId', null, token!));

    var dislikeResult = await handleResponse(
        await getRequest('$dislikeEp?forum.id=$copId', null, token));
    var komentarResult = await handleResponse(
        await getRequest('$komentarEp?forum.id=$copId', null, token));

    PageDetailCopModel detailCopModel = PageDetailCopModel(
        like: FeedbackModel.fromJson(likeResult),
        dislike: FeedbackModel.fromJson(dislikeResult),
        komentar: FeedbackModel.fromJson(komentarResult));

    return detailCopModel;
  }

  @override
  Future<Object>? likePostCop(int forumId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("kesini ga siii");
    final String? token = prefs.getString('token');
    var submitResult = await handleResponse(
        await postRequest('$copSubmit/$forumId/like', {}, token!));
    return submitResult;
  }

  @override
  Future<Object>? dislikePostCop(int forumId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var submitResult = await handleResponse(
        await postRequest('$copSubmit/$forumId/dislike', {}, token!));
    return submitResult;
  }

  @override
  Future<FeedbackModelResult>? commentPostCop(Map pParam) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var response =
        await handleResponse(await postRequest(komentarEp, pParam, token!));
    FeedbackModelResult result = FeedbackModelResult.fromJson(response);

    return result;
  }
}
