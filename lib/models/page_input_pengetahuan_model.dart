import 'package:kms_bpkp_mobile/models/api_hashtag_model.dart';
import 'package:kms_bpkp_mobile/models/api_lingkup_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_pedoman_model.dart';
import 'package:kms_bpkp_mobile/models/api_penerbit_model.dart';
import 'package:kms_bpkp_mobile/models/api_pengarang_model%20.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_penulis_model.dart';
import 'package:kms_bpkp_mobile/models/api_referensi_model.dart';
import 'package:kms_bpkp_mobile/models/api_sub_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_tenaga_ahli_model.dart';

class PageInputPengetahuanModel {
  SubJenisPengetahuanModel subJenisPengetahuanModel;
  ReferensiModel referensiModel;
  TenagaAhliModel tenagaAhliModel;
  PedomanModel pedomanModel;
  PenulisModel penulisModel;
  PengarangModel pengarangModel;
  PenerbitModel penerbitModel;
  HashTagModel hashTagModel;
  LingkupPengetahuanModel lingkupPengetahuanModel;
  PageInputPengetahuanModel(
      {required this.subJenisPengetahuanModel,
      required this.referensiModel,
      required this.tenagaAhliModel,
      required this.pedomanModel,
      required this.penulisModel,
      required this.pengarangModel,
      required this.penerbitModel,
      required this.lingkupPengetahuanModel,
      required this.hashTagModel});
}
