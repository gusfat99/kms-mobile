// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart' as text;
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:form_validator/form_validator.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/loading_screen.dart';
import 'package:kms_bpkp_mobile/helpers/my_validation_locale.dart';
import 'package:kms_bpkp_mobile/helpers/text_field_widget.dart';
import 'package:kms_bpkp_mobile/models/api_hashtag_model.dart';
import 'package:kms_bpkp_mobile/models/api_lingkup_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_penerbit_model.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_penulis_model.dart';
import 'package:kms_bpkp_mobile/models/api_post_attachment_model.dart';
import 'package:kms_bpkp_mobile/models/api_sub_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_tenaga_ahli_model.dart';
import 'package:kms_bpkp_mobile/models/common_model.dart';
import 'package:kms_bpkp_mobile/models/page_input_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/screens/berbagi/api/input_pengetahuan_api.dart';
import 'package:kms_bpkp_mobile/screens/error/error_screen.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:kms_bpkp_mobile/utils.dart';
import 'package:kms_bpkp_mobile/wigets/custom_dropdown_multiple_search.dart';
import 'package:kms_bpkp_mobile/wigets/upload_button_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class FileData {
  final int urutan;
  final File file;

  FileData({required this.urutan, required this.file});
}

class GeneralKnowlegeScreen extends StatefulWidget {
  const GeneralKnowlegeScreen(
      {super.key,
      required this.title,
      required this.id_jenis,
      required this.sub_jenis_pengethuan,
      required this.id_sub_jenis_pengetahuan});
  final String title;
  final int id_jenis;
  final String sub_jenis_pengethuan;
  final int id_sub_jenis_pengetahuan;
  @override
  State<GeneralKnowlegeScreen> createState() => _GeneralKnowlegeScreenState();
}

class _GeneralKnowlegeScreenState extends State<GeneralKnowlegeScreen> {
  final _formKey = GlobalKey<FormState>();

  List<Widget> hashtagWidgets = <Widget>[];
  List<Widget> documentWidgets2 = <Widget>[];
  List<SubJenisPengetahuanResult> subJenisPengetahuan = [];
  List<PengetahuanResult> referensiResult = [];
  List<PenerbitResult> penerbitResult = [];
  List<PenulisResult> penulisResult = [];
  List<HashTagResult> hashtagResult = [];
  List<String> subJenis = <String>[];
  List<String> referensi = <String>[];
  List<String> penulis = <String>[];
  List<String> hashtag = <String>[];
  List<File> document = <File>[];
  List<LingkupPengetahuanResult> lingkupPengetahuanResult = [];
  List<TenagaAhliResult> tenagaAhliResult = [];
  List<OptionsModel> _selectedReferensi = [];
  List<OptionsModel> _selectedPenulis = [];

  List<FileData> docs = [];

  String file_gambar = "Pilih Gambar";
  List<String> file_dokumen = [];

  List<File> file_gambar_send = [];

  var _judul = "";
  var _ringkasan = "";
  var _lingkup_pengetahuan = "";
  var _status_pengetahuan = "";

  @override
  void initState() {
    setState(() {
      file_gambar_send.add(File(""));

      hashtagWidgets.add(_hashtag());
    });

    _addDoc();
    super.initState();
  }

  void _addDoc() {
    setState(() {
      file_dokumen.add("Pilih Dokumen");
    });
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      //_formKey.currentState!.save();
      AppUtils.hideKeyboard(context);

      //HASHTAG
      var hashtag_send = [];
      List<String> hashtag_send_api = [];
      for (int i = 0; i < hashtagWidgets.length; i++) {
        var hasName = hastagSelected[i];
        var hasId = 0;
        for (var element in hashtagResult) {
          if (element.nama == hasName) {
            hasId = element.id;
            hashtag_send.add({"id": hasId});
          }
        }
        if (hasId == 0) {
          hashtag_send_api.add(hasName);
        }
      }

      try {
        var value_hastag =
            await InputPengetahuanService().submitNewHashTag(hashtag_send_api);
        for (var hastag in value_hastag!) {
          hashtag_send.add({"id": hastag});
        }

        docs.sort((a, b) => a.urutan.compareTo(b.urutan));
        if (docs.where((doc) => doc.urutan == 0).isEmpty) {
          throw 'Silahkan unggah gambar!';
        }

        List<File> docs_send = docs.map((doc) => doc.file).toList();

        List<PostAttachModel>? value_dokumen = await InputPengetahuanService()
            .submitNewKnowledgeAttachment(docs_send);

        Map req = {
          "jenis_pengetahuan": {"id": widget.id_jenis.toString()},
          "subjenis_pengetahuan": {
            "id": widget.id_sub_jenis_pengetahuan.toString()
          },
          "judul": _judul,
          "ringkasan": _ringkasan,
          "referensi_pengetahuan": _selectedReferensi
              .map((x) => ({"id": x.value.toString()}))
              .toList(),
          "tag": hashtag_send,
          "thumbnail": {"id": value_dokumen![0].id.toString()},
          "dokumen": value_dokumen
              .where((item) => value_dokumen.indexOf(item) != 0)
              .map((item) => ({"id": item.id.toString()}))
              .toList(),
          "lingkup_pengetahuan": {"id": _lingkup_pengetahuan},
          "status_pengetahuan": _status_pengetahuan
        };

        int i = 0;
        for (var penulis in _selectedPenulis) {
          req['penulis_$i'] = {"id": penulis.value?.toString()};
          i++;
        }

        var submitPengetahuan =
            await InputPengetahuanService().submitNewKnowledge(req);

        toasty(context, "SUCCESS!");
        finish(context);
      } catch (e) {
        print(e);
        toasty(context, "${e.toString()}");
      }
    } else {
      toasty(context, "Silahkan periksa form anda!!");
    }
  }

  final locale = MyValidationLocale();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PageInputPengetahuanModel>(
        future: InputPengetahuanService().getInputPengetahuanData(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            //SUB JENIS PENGETAHUAN
            subJenisPengetahuan =
                snapshot.data!.subJenisPengetahuanModel.results;
            subJenis.clear();
            subJenis.add("");
            for (var i = 0; i < subJenisPengetahuan.length; i++) {
              subJenis.add(subJenisPengetahuan[i].nama);
            }
            //REFERENSI
            referensi.clear();
            referensi.add("");
            referensiResult =
                snapshot.data!.pengetahuanModel.pengetahuanResults;
            for (var i = 0; i < referensiResult.length; i++) {
              referensi.add(referensiResult[i].judul);
            }

            //PENULIS
            penulisResult = snapshot.data!.penulisModel.results;
            for (var i = 0; i < penulisResult.length; i++) {
              penulis.add(penulisResult[i].namaLengkap);
            }

            //HASHTAG
            hashtag.clear();
            hashtag.add("");
            hashtagResult = snapshot.data!.hashTagModel.results;
            for (var i = 0; i < hashtagResult.length; i++) {
              hashtag.add(hashtagResult[i].nama);
            }
            lingkupPengetahuanResult =
                snapshot.data!.lingkupPengetahuanModel.results;
            tenagaAhliResult = snapshot.data!.tenagaAhliModel.results;

            List<OptionsModel> optionsReferensi = referensiResult
                .map((ref) => OptionsModel(label: ref.judul, value: ref.id))
                .toList();

            List<OptionsModel> optionsPenulis = snapshot
                .data!.penulisModel.results
                .map((p) => OptionsModel(label: p.namaLengkap, value: p.id))
                .toList();

            //Lingkup Pengetahuan

            return Scaffold(
              appBar: buildAppBar(),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.height,
                        TextFieldWidget(
                          label: "Sub Jenis Pengetahuan",
                          text: widget.sub_jenis_pengethuan,
                          readonly: true,
                          onChanged: (value) {
                            //_judul = value;
                          },
                        ),
                        15.height,
                        TextFieldWidget(
                          label: "Judul Pengetahuan",
                          text: _judul,
                          validator: ValidationBuilder(locale: locale).build(),
                          readonly: false,
                          onChanged: (value) {
                            setState(() {
                              _judul = value;
                            });
                          },
                        ),
                        15.height,
                        TextFieldWidget(
                          label: "Ringkasan",
                          text: _ringkasan,
                          validator: ValidationBuilder(locale: locale).build(),
                          maxLines: 5,
                          readonly: false,
                          onChanged: (value) {
                            setState(() {
                              _ringkasan = value;
                            });
                          },
                        ),
                        15.height,
                        CustomDropdownMultipleSearch(
                            label: 'Referensi *',
                            options: optionsReferensi,
                            validator: (items) {
                              if (items == null || items.isEmpty) {
                                return "Referensi wajib diisi minimal 1";
                              }
                              return null;
                            },
                            onChanged: (data) {
                              setState(() {
                                _selectedReferensi = data;
                              });
                            },
                            selectedItems: _selectedReferensi),
                        15.height,
                        const text.Text(
                          "PENULIS PENGETAHUAN",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        10.height,
                        CustomDropdownMultipleSearch(
                            label: "Nama Penulis *",
                            options: optionsPenulis,
                            validator: (items) {
                              if (items == null || items.isEmpty) {
                                return "Nama Penulis wajib diisi minimal 1";
                              }
                              return null;
                            },
                            onChanged: (data) {
                              setState(() {
                                _selectedPenulis = data;
                              });
                            },
                            selectedItems: _selectedPenulis),
                        15.height,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: hashtagWidgets,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              hashtagWidgets.add(_hashtag());
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent.withOpacity(0),
                            side: const BorderSide(
                              width: 0,
                              color: Colors.transparent,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.add_rounded,
                                  color: Colors.blue, size: 20),
                              6.width,
                              const text.Text(
                                "Tambah Hashtag",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        15.height,
                        const text.Text(
                          "UPLOAD DOKUMEN",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        15.height,
                        UploadButtonWidget(
                          label: 'File Gambar *',
                          allowedExtensions: const ['jpg', 'png', 'jpeg'],
                          onChanged: (file) {
                            docs.add(FileData(urutan: 0, file: file));
                          },
                        ),
                        15.height,
                        UploadButtonWidget(
                          label: 'File Dokumen',
                          allowedExtensions: const [
                            'pdf',
                            'jpeg',
                            'jpg',
                            'png'
                          ],
                          onChanged: (file) {
                            docs.add(FileData(urutan: 1, file: file));
                          },
                        ),
                        15.height,
                        const text.Text(
                          "Status Pengetahuan",
                          style: TextStyle(fontSize: 16, color: textColor),
                          textAlign: TextAlign.start,
                        ),
                        5.height,
                        DropdownButtonFormField<String>(
                          validator: ValidationBuilder(locale: locale).build(),
                          items: ["1", "2"]
                              .map<DropdownMenuItem<String>>((status) {
                            return DropdownMenuItem(
                              value: status,
                              child: text.Text(
                                status == "1" ? "Aktif" : "Tidak Aktif",
                                style: const TextStyle(
                                    fontSize: 16, color: textColor),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _status_pengetahuan = value ?? "";
                              // _selectedJenisPengetahuan = value!;
                            });
                            // _kategori = value!;
                          },
                        ),
                        15.height,
                        const text.Text(
                          "Lingkup Pengetahuan",
                          style: TextStyle(fontSize: 16, color: textColor),
                          textAlign: TextAlign.start,
                        ),
                        5.height,
                        DropdownButtonFormField<String>(
                          validator: ValidationBuilder(locale: locale).build(),
                          items: lingkupPengetahuanResult
                              .map<DropdownMenuItem<String>>(
                                  (LingkupPengetahuanResult lingkup) {
                            return DropdownMenuItem(
                              value: lingkup.id.toString(),
                              child: text.Text(
                                lingkup.nama,
                                style: const TextStyle(
                                    fontSize: 16, color: textColor),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _lingkup_pengetahuan = value.toString();
                              // _selectedJenisPengetahuan = value!;
                            });
                            // _kategori = value!;
                          },
                        ),
                        15.height,
                        ElevatedButton(
                          onPressed: () async {
                            handleSubmit();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shadowColor: Colors.transparent.withOpacity(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.save,
                                    color: whiteColor, size: 20),
                                6.width,
                                const text.Text(
                                  "SIMPAN",
                                  style: TextStyle(color: whiteColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        50.height
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return ErrorScreen(snapshot.toString());
          }
          return LoadingScreen();
        });
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      toolbarHeight: 80.0,
      leading: BackButton(
        color: whiteClr,
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            boxShadow: defaultBoxShadow(
                shadowColor: grayColorL2,
                blurRadius: 13,
                offset: const Offset(0.0, 5.0)),
            image: const DecorationImage(
                image: AssetImage('assets/images/back_header.png'),
                fit: BoxFit.fill)),
      ),
      backgroundColor: whiteColor,
      title: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: text.Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).expand(),
              // Container(
              //   margin: const EdgeInsets.only(top: 0),
              //   child: IconBtnWithCounter(
              //     svgSrc: "assets/icons/bell2.svg",
              //     numOfitem: "10", //notifCounter,
              //     press: () {
              //       Navigator.pushNamed(context, notificationRoute);
              //     },
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  int windex_referensi = 0;
  var referensiSelected = <String>[];
  Widget _referensi() {
    setState(() {
      windex_referensi++;
      referensiSelected.add("");
    });
    return Column(
      children: [
        15.height,
        FastAutocomplete<String>(
          name: 'referensi',
          labelText: 'Referensi',
          options: referensi,
          initialValue:
              TextEditingValue(text: referensiSelected[windex_referensi - 1]),
          onChanged: (value) {
            setState(() {
              referensiSelected[windex_referensi - 1] = value!;
            });
          },
          onSelected: (option) {
            setState(() {
              referensiSelected[windex_referensi - 1] = option;
            });
          },
        ),
      ],
    );
  }

  int windex_hastag = 0;
  var hastagSelected = <String>[];
  Widget _hashtag() {
    setState(() {
      windex_hastag++;
      hastagSelected.add("");
    });
    return Column(
      children: [
        15.height,
        FastAutocomplete<String>(
          name: 'hastag',
          labelText: 'Hastag',
          options: hashtag,
          validator: ValidationBuilder(locale: locale).build(),
          initialValue:
              TextEditingValue(text: hastagSelected[windex_hastag - 1]),
          onChanged: (value) {
            setState(() {
              hastagSelected[windex_hastag - 1] = value!;
            });
          },
          onSelected: (option) {
            setState(() {
              hastagSelected[windex_hastag - 1] = option;
            });
          },
        ),
      ],
    );
  }
}
