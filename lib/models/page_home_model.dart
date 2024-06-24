import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_slider_model.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';

class PageHomeModel {
  PengetahuanModel pengetahuanModel;
  List<SliderModel> sliderModel;
  CopModel copModel;
  User user;
  int notificationCounter;
  PageHomeModel(
      {required this.pengetahuanModel,
      required this.sliderModel,
      required this.copModel,
      required this.user,
      required this.notificationCounter});
}
