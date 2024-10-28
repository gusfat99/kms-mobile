import 'package:kms_bpkp_mobile/models/api_feedback_model.dart';
import 'package:kms_bpkp_mobile/models/api_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';

class PageKnowledgeModel {
  PengetahuanModel pengetahuanModel;
  JenisPengetahuanModel jenisPengetahuanModel;
  User user;
  PageKnowledgeModel(
      {required this.pengetahuanModel,
      required this.jenisPengetahuanModel,
      required this.user});
}

class PageKnowledgeDetailModel {
  PengetahuanModel pengetahuanModel;
  FeedbackModel feedbackModel;
  PageKnowledgeDetailModel(
      {required this.pengetahuanModel, required this.feedbackModel});
}
