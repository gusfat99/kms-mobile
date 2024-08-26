import 'dart:io';

import 'package:kms_bpkp_mobile/app.dart';
import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_post_attachment_model.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';
import 'package:kms_bpkp_mobile/models/page_berbagi_model.dart';
import 'package:kms_bpkp_mobile/models/page_cop_model.dart';
import 'package:kms_bpkp_mobile/models/page_home_model.dart';
import 'package:kms_bpkp_mobile/models/page_input_cop_model.dart';
import 'package:kms_bpkp_mobile/models/page_input_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/page_knowledge_model.dart';
import 'package:kms_bpkp_mobile/models/page_search_cop_model.dart';
import 'package:kms_bpkp_mobile/models/page_search_model.dart';

String loginEp = "${appBaseUrl}api/v1/login";
String sliderEp = "${appBaseUrl}api/v1/slider_pengetahuan";
String pengetahuanEp = "${appBaseUrl}api/v1/pengetahuan";
String searchPengetahuanEp = "${appBaseUrl}api/v1/search_pengetahuan";
String searchCopEp = "${appBaseUrl}api/v1/search_forum";
String pengetahuanJenisEp = "${appBaseUrl}api/v1/jenis_pengetahuan";
String pengetahuanSubJenisEp = "${appBaseUrl}api/v1/subjenis_pengetahuan";
String copEp = "${appBaseUrl}api/v1/forum";
String referensiEp = "${appBaseUrl}api/v1/referensi";
String penulisEp = "${appBaseUrl}api/v1/orang";
String hashtagEp = "${appBaseUrl}api/v1/tag";
String tenagaAhliEp = "${appBaseUrl}api/v1/orang";
String pedomanEp = "${appBaseUrl}api/v1/pedoman";
String pengarangEp = "${appBaseUrl}api/v1/orang";
String penerbitEp = "${appBaseUrl}api/v1/orang";
String pengetahuanSubmitReferensi = "${appBaseUrl}api/v1/referensi";
String pengetahuanSubmitHashTag = "${appBaseUrl}api/v1/tag";
String pengetahuanSubmitAttachment = "${appBaseUrl}api/v1/attachments";
String pengetahuanSubmit = "${appBaseUrl}api/v1/pengetahuan";
String copSubmit = "${appBaseUrl}api/v1/forum";
String lingkupPengetahuanEp = "${appBaseUrl}api/v1/lingkup_pengetahuan";

//==> Json Dummy
// String loginEpJson = "assets/json/token_result.json";
// String pengetahuanEpJson = "assets/json/pengetahuan_result.json";
// String jenisPengetahuanEpJson = "assets/json/jenis_pengetahuan_result.json";
// String notificationEpJson = "assets/json/notification_result.json";
// String calendarEpJson = "assets/json/calendar_result.json";

String copKategoriEpJson = "assets/json/kategori_cop_result.json";

class AuthApiService {
  Future<TokenModel>? getAccessToken(Map req) {
    return null;
  }
}

class HomeApiService {
  //HOME SCREEN
  Future<PageHomeModel>? getHomeData() {
    return null;
  }
}

class KnowledgeApiService {
  //KNOWLEDGE SCREEN
  Future<PageKnowledgeModel>? getKnowledgeData(String selectedId) {
    return null;
  }

  //PENGETAHUAN
  Future<PengetahuanModel>? getPengetahuan() {
    return null;
  }

  //PENGETAHUAN BY JENIS
  Future<PengetahuanModel>? getPengetahuanByJenis(String jenisPengetahuan) {
    return null;
  }

  //JENIS PENGETAHUAN
  Future<PageBerbagiModel>? getJenisPengetahuan() {
    return null;
  }
}

class SearchKnowledgeApiService {
  //SEARCH KNOWLEDGE SCREEN
  Future<PageSearchKnowledgeModel>? getSearchKnowledgeData(
      int page, int limit, String searchKey) {
    return null;
  }
}

class SearchCopApiService {
  //SEARCH COP SCREEN
  Future<PageSearchCopModel>? getSearchCopData(
      int page, int limit, String searchKey) {
    return null;
  }
}

class CopApiService {
  Future<PageInputCopModel>? getInputCopData() {
    return null;
  }

  //COP SCREEN
  Future<PageCopModel>? getCopData() {
    return null;
  }

  //COP
  Future<CopModel>? getCop() {
    return null;
  }

//SUBMIT
  Future<Object>? submitNewCOP(Map pParam) {}
}

class InputPengetahuanApiService {
  //INPUT PENGETAHUAN SCREEN
  Future<PageInputPengetahuanModel>? getInputPengetahuanData() {
    return null;
  }

  //SUBMIT REFERENSI
  Future<List<int>>? submitNewReferensi(List<String> referensi_send_api) {
    return null;
  }

  //SUBMIT PENULIS
  Future<List<int>>? submitNewPenulis(List<String> penulis_send_api) {
    return null;
  }

  //SUBMIT HASHTAG
  Future<List<int>>? submitNewHashTag(List<String> hashtag_send_api) {
    return null;
  }

  //SUBMIT ATTACHMENT
  Future<List<PostAttachModel>>? submitNewKnowledgeAttachment(List<File> file) {
    return null;
  }

  //SUBMIT INPUT PENGETAHUAN
  Future<Object>? submitNewKnowledge(Map pParam) {
    return null;
  }


}
