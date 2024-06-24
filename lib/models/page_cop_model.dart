import 'package:kms_bpkp_mobile/models/api_cop_kategori.dart';
import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';

class PageCopModel {
  CopModel copModel;
  CopKategoriModel copKategoriModel;
  User user;
  PageCopModel({required this.copModel,required this.copKategoriModel, required this.user});
}
