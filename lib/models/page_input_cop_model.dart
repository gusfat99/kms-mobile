import 'package:kms_bpkp_mobile/models/api_cop_kategori.dart';
import 'package:kms_bpkp_mobile/models/api_hashtag_model.dart';
// import 'package:kms_bpkp_mobile/models/api_hashtag_model.dart';
import 'package:kms_bpkp_mobile/models/api_jenis_pengetahuan_model.dart';

class PageInputCopModel {
  CopKategoriModel copKategoriModel;
  HashTagModel hashTagModel;
  JenisPengetahuanModel jenisPengetahuanModel;

  PageInputCopModel(
      {required this.copKategoriModel,
      required this.hashTagModel,
      required this.jenisPengetahuanModel});
}
