import 'dart:io';

import 'package:kms_bpkp_mobile/apis/request.dart';
import 'package:kms_bpkp_mobile/apis/response.dart';
import 'package:kms_bpkp_mobile/apis/services.dart';
import 'package:kms_bpkp_mobile/models/api_hashtag_model.dart';
import 'package:kms_bpkp_mobile/models/api_new_referensi_model.dart';
import 'package:kms_bpkp_mobile/models/api_new_tag_model.dart';
import 'package:kms_bpkp_mobile/models/api_pedoman_model.dart';
import 'package:kms_bpkp_mobile/models/api_penerbit_model.dart';
import 'package:kms_bpkp_mobile/models/api_pengarang_model%20.dart';
import 'package:kms_bpkp_mobile/models/api_penulis_model.dart';
import 'package:kms_bpkp_mobile/models/api_post_attachment_model.dart';
import 'package:kms_bpkp_mobile/models/api_referensi_model.dart';
import 'package:kms_bpkp_mobile/models/api_sub_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_tenaga_ahli_model.dart';
import 'package:kms_bpkp_mobile/models/page_input_pengetahuan_model.dart';
import 'package:nb_utils/nb_utils.dart';

class InputPengetahuanService implements InputPengetahuanApiService {
  @override
  Future<PageInputPengetahuanModel> getInputPengetahuanData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {};
    //SUB JENIS PENGETAHUAN
    var resultSubJenisPengetahuan = await handleResponse(
        await getRequest(pengetahuanSubJenisEp, apiParam, token!));

    //REFERENSI
    var resultReferensi =
        await handleResponse(await getRequest(referensiEp, apiParam, token));
    print("resultReferensi");
    //TENAGA AHLI
    var resultTenagaAhli =
        await handleResponse(await getRequest(tenagaAhliEp, apiParam, token));
    print("resultTenagaAhli");
    //PEDOMAN
    var resultPedoman =
        await handleResponse(await getRequest(pedomanEp, apiParam, token));
    print("resultPedoman");
    //PENULIS
    var resultPenulis =
        await handleResponse(await getRequest(penulisEp, apiParam, token));
    print("resultPenulis");
    //PENGARANG
    var resultPengarang =
        await handleResponse(await getRequest(pengarangEp, apiParam, token));
    print("resultPengarang");
    //PENERBIT
    var resultPenerbit =
        await handleResponse(await getRequest(penerbitEp, apiParam, token));
    print("resultPenerbit");
    //HASHTAG
    var resultHashTag =
        await handleResponse(await getRequest(hashtagEp, apiParam, token));
    print("resultHashTag");

    PageInputPengetahuanModel inputPengetahuanData = PageInputPengetahuanModel(
        subJenisPengetahuanModel:
            SubJenisPengetahuanModel.fromJson(resultSubJenisPengetahuan),
        referensiModel: ReferensiModel.fromJson(resultReferensi),
        tenagaAhliModel: TenagaAhliModel.fromJson(resultTenagaAhli),
        pedomanModel: PedomanModel.fromJson(resultPedoman),
        penulisModel: PenulisModel.fromJson(resultPenulis),
        pengarangModel: PengarangModel.fromJson(resultPengarang),
        penerbitModel: PenerbitModel.fromJson(resultPenerbit),
        hashTagModel: HashTagModel.fromJson(resultHashTag));

    return inputPengetahuanData;
  }

  @override
  Future<List<int>>? submitNewReferensi(List<String> referensi_send_api) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    List<int> resultApi = [];
    for (int i = 0; i < referensi_send_api.length; i++) {
      Map<String, String> apiParam = {"referensi": referensi_send_api[i]};
      var resultPost = await handleResponse(
          await postRequest(pengetahuanSubmitReferensi, apiParam, token!));
      NewReferensiModel resultPostRef = NewReferensiModel.fromJson(resultPost);
      resultApi.add(resultPostRef.id);
    }

    return resultApi;
  }

  @override
  Future<List<int>>? submitNewPenulis(List<String> penulis_send_api) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    List<int> resultApi = [];
    // penulis_send_api.forEach((element) async {
    //   Map<String, String> apiParam = {"nama": element};
    //   var resultPost = await handleResponse(
    //       await postRequest(pengetahuanSubmitReferensi, apiParam, token!));
    //   NewReferensiModel resultPostRef = NewReferensiModel.fromJson(resultPost);
    //   resultApi.add(resultPostRef.id);
    // });
    return resultApi;
  }

  @override
  Future<List<int>>? submitNewHashTag(List<String> hashtag_send_api) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    List<int> resultApi = [];
    for (int i = 0; i < hashtag_send_api.length; i++) {
      Map<String, String> apiParam = {"nama": hashtag_send_api[i]};
      var resultPost = await handleResponse(
          await postRequest(pengetahuanSubmitHashTag, apiParam, token!));
      NewTagModel resultPostRef = NewTagModel.fromJson(resultPost);
      resultApi.add(resultPostRef.id);
    }

    return resultApi;
  }

  @override
  Future<List<PostAttachModel>>? submitNewKnowledgeAttachment(
      List<File> files) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Map<String, String> apiParam = {};

    List<PostAttachModel> resultApi = [];
    for (int i = 0; i < files.length; i++) {
      var resultPostAttach = await handleResponse(await postRequestWithFile(
          pengetahuanSubmitAttachment, apiParam, files[i], token!));
      PostAttachModel resultPostRef =
          PostAttachModel.fromJson(resultPostAttach);
      resultApi.add(resultPostRef);
    }
    return resultApi;
  }

  @override
  Future<Object>? submitNewKnowledge(Map pParam) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var submitResult = await handleResponse(
        await postRequest(pengetahuanSubmit, pParam, token!));
    return submitResult;
  }
}
