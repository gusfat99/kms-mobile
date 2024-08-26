// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart' as text;
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/loading_screen.dart';
import 'package:kms_bpkp_mobile/helpers/text_field_widget.dart';
import 'package:kms_bpkp_mobile/models/api_hashtag_model.dart';
import 'package:kms_bpkp_mobile/models/api_lingkup_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_penulis_model.dart';
import 'package:kms_bpkp_mobile/models/api_post_attachment_model.dart';
import 'package:kms_bpkp_mobile/models/api_referensi_model.dart';
import 'package:kms_bpkp_mobile/models/api_sub_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/page_input_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/screens/berbagi/api/input_pengetahuan_api.dart';
import 'package:kms_bpkp_mobile/screens/error/error_screen.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:kms_bpkp_mobile/utils.dart';
import 'package:kms_bpkp_mobile/wigets/upload_button_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class KiatScreen extends StatefulWidget {
  const KiatScreen(
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
  State<KiatScreen> createState() => _KiatScreenState();
}

class _KiatScreenState extends State<KiatScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Widget> referensiWidgets = <Widget>[];
  List<Widget> penulisWidgets = <Widget>[];
  List<Widget> hashtagWidgets = <Widget>[];
  List<Widget> documentWidgets2 = <Widget>[];
  List<SubJenisPengetahuanResult> subJenisPengetahuan = [];
  List<ReferensiResult> referensiResult = [];
  List<PenulisResult> penulisResult = [];
  List<HashTagResult> hashtagResult = [];
  List<String> subJenis = <String>[];
  List<String> referensi = <String>[];
  List<String> penulis = <String>[];
  List<String> hashtag = <String>[];
  List<File> document = <File>[];
  List<LingkupPengetahuanResult> lingkupPengetahuanResult = [];

  String file_gambar = "Pilih Gambar";
  List<String> file_dokumen = [];

  List<File> file_gambar_send = [];
  List<File> file_docs_send = [];

  int file_gambar_id = 0;
  List<int> file_dokumen_id = [];

  // final QuillController _ringkasan_controller = QuillController.basic();
  // final QuillController _masalah_controller = QuillController.basic();
  // final QuillController _dampak_controller = QuillController.basic();
  // final QuillController _penyebab_controller = QuillController.basic();
  // final QuillController _solusi_controller = QuillController.basic();
  // final QuillController _syarat_controller = QuillController.basic();

  var _judul = "";
  var _ringkasan = "";
  var _masalah = "";
  var _dampak = "";
  var _penyebab = "";
  var _solusi = "";
  var _hasil_perbaikan = "";
  var _lingkup_pengetahuan = "";

  @override
  void initState() {
    setState(() {
      file_gambar_send.add(File(""));
      file_docs_send.add(File(""));
      referensiWidgets.add(_referensi());
      penulisWidgets.add(_penulis());
      hashtagWidgets.add(_hashtag());
    });

    _addDoc();
    super.initState();
  }

  void _addDoc() {
    setState(() {
      windex_document++;
      file_dokumen.add("Pilih Dokumen");
      documentSelected.add(File(""));
    });
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      //_formKey.currentState!.save();
      AppUtils.hideKeyboard(context);

      //REFERENSI
      List<Map<dynamic, dynamic>> referensi_send = [];
      List<String> referensi_send_api = [];
      for (int i = 0; i < referensiWidgets.length; i++) {
        var refName = referensiSelected[i];
        var refId = 0;
        for (var element in referensiResult) {
          if (element.referensi == refName) {
            refId = element.id;
            referensi_send.add({"id": refId});
          }
        }
        if (refId == 0) {
          referensi_send_api.add(refName);
        }
      }
      //PENULIS
      var penulis_send = [];
      List<String> penulis_send_api = [];
      for (int i = 0; i < penulisWidgets.length; i++) {
        var penName = penulisSelected[i];
        var penId = 0;
        for (var element in penulisResult) {
          if (element.namaLengkap == penName) {
            penId = element.id;
            penulis_send.add({"id": penId});
          }
        }
        if (penId == 0) {
          penulis_send_api.add(penName);
        }
      }
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
      //DOCUMENT
      List<File> document_send_api = [];
      for (int i = 0; i <= documentWidgets2.length; i++) {
        File docFile = documentSelected[i];
        document_send_api.add(docFile);
      }

      try {
        //SEND REFERENSI
        var value_ref = await InputPengetahuanService()
            .submitNewReferensi(referensi_send_api);

        for (var referensi in value_ref!) {
          referensi_send.add({"id": referensi});
        }

        // var value_penulis =
        //     await InputPengetahuanService().submitNewPenulis(penulis_send_api);
        // print("value_penulis");
        // print(value_penulis);
        // for (var penulis in value_penulis!) {
        //   penulis_send.add({"id": penulis});
        // }
        // var value_penulis =
        //     await InputPengetahuanService().submitNewPenulis(penulis_send_api);
        var value_hastag =
            await InputPengetahuanService().submitNewHashTag(hashtag_send_api);
        for (var hastag in value_hastag!) {
          hashtag_send.add({"id": hastag});
        }
        // print("file_gambar_send");
        List<PostAttachModel>? value_gambar = await InputPengetahuanService()
            .submitNewKnowledgeAttachment(file_gambar_send);

        List<PostAttachModel>? value_dokumen = await InputPengetahuanService()
            .submitNewKnowledgeAttachment(file_docs_send);

        // for (int i = 0; i < value_ref!.length; i++) {
        //   penulis_send.add({"id": value_ref[i]});
        // }


        Map req = {
          "jenis_pengetahuan": {"id": widget.id_jenis.toString()},
          "subjenis_pengetahuan": {
            "id": widget.id_sub_jenis_pengetahuan.toString()
          },
          "judul": _judul,
          // "ringkasan": ringkasan,
          "referensi": referensi_send,
          "masalah": _masalah,
          "dampak": _dampak,
          "penyebab": _penyebab,
          "solusi": _solusi,
          "hasil_perbaikan": _hasil_perbaikan,
          // "penulis_1": {"id": 1},
          "tag": hashtag_send,
          "thumbnail": {"id": value_gambar?[0].id},
          "dokumen": {"id": value_dokumen?[0].id},
          "lingkup_pengetahuan": {"id": _lingkup_pengetahuan},
          "kompetensi": {}
        };


        var submitPengetahuan =
            await InputPengetahuanService().submitNewKnowledge(req);

        // print(submitPengetahuan);
        toasty(context, "SUCCESS!");
        finish(context);

        // setState(() {
        // file_gambar_id = value_gambar![0].id;
        // file_dokumen_id = [value_dokumen![0].id];

        // for (int i = 0; i < value_ref.length; i++) {
        //   penulis_send.add({"id": value_ref[i]});
        // }
        // for (int i = 0; i < hastag_ref!.length; i++) {
        //   hashtag_send.add({"id": hastag_ref[i]});
        // }
        // });
      } catch (e) {
        print(e);
        toasty(context, "error!! ${e.toString()}");
      }

      //NEXT
      //SEND PENULIS
      // await InputPengetahuanService()
      //     .submitNewPenulis(penulis_send_api)
      //     ?.then((value_ref) async {
      //   setState(() {
      //     for (int i = 0; i < value_ref.length; i++) {
      //       penulis_send.add({"id": value_ref[i]});
      //     }
      //   });
      //   //NEXT
      //   //SEND TAG
      //   await InputPengetahuanService()
      //       .submitNewHashTag(hashtag_send_api)
      //       ?.then((value_ref) async {
      //     setState(() {
      //       for (int i = 0; i < value_ref.length; i++) {
      //         hashtag_send.add({"id": value_ref[i]});
      //       }
      //     });
      //     //NEXT

      //   }).catchError((e) {
      //     toasty(context, "4 : $e");
      //   });
      // }).catchError((e) {
      //   toasty(context, "3 : $e");
      // });
      //SEND IMAGE

      // await InputPengetahuanService()
      //     .submitNewKnowledgeAttachment(file_gambar_send)
      //     ?.then((value_gambar) async {
      //   setState(() {
      //     file_gambar_id = value_gambar[0].id;
      //   });
      //   //NEXT
      //   //SEND DOC
      //   InputPengetahuanService()
      //       .submitNewKnowledgeAttachment(document_send_api)
      //       ?.then((value_dokumen) {
      //     setState(() {
      //       for (int x = 0; x < value_dokumen.length; x++) {
      //         file_dokumen_id.add(value_dokumen[x].id);
      //       }
      //     });
      //     //NEXT
      //     //SUBMIT ALL
      //     //SEND FORM
      //     var docs_send = [];
      //     for (int ii = 0; ii < file_dokumen_id.length; ii++) {
      //       docs_send.add({"id": file_dokumen_id[ii]});
      //     }

      //     var kompetensi_send = [];
      //     //kompetensi_send.add({"id": 1});

      //         ?.then((value_submit) {
      //       toasty(context, "SUCCESS!");
      //       finish(context);
      //     }).catchError((e) {
      //       toasty(context, "7 : $e");
      //     });
      //   }).catchError((e) {
      //     toasty(context, "6 : $e");
      //   });
      // }).catchError((e) {
      //   toasty(context, "5 : $e");
      // });
    } else {
      toasty(context, "1 : " + "validate!!");
    }
  }

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
            referensiResult = snapshot.data!.referensiModel.results;
            for (var i = 0; i < referensiResult.length; i++) {
              referensi.add(referensiResult[i].referensi);
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
                          maxLines: 5,
                          readonly: false,
                          onChanged: (value) {
                            setState(() {
                              _ringkasan = value;
                            });
                          },
                        ),

                        15.height,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: referensiWidgets,
                        ),
                        // FastAutocomplete<String>(
                        //   name: 'referensi',
                        //   labelText: 'Referensi',
                        //   options: referensi,
                        // ),
                        15.height,
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              referensiWidgets.add(_referensi());
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
                                "Tambah Referensi",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        15.height,
                        const text.Text(
                          "PERMASALAHAN",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        10.height,
                        // const text.Text(
                        //   "Masalah",
                        //   style: TextStyle(fontSize: 16),
                        // ),
                        5.height,
                        TextFieldWidget(
                          label: "Masalah",
                          text: _masalah,
                          maxLines: 5,
                          readonly: false,
                          onChanged: (value) {
                            setState(() {
                              _masalah = value;
                            });
                          },
                        ),
                        // _quill_toolbar(_masalah_controller),
                        // _quill_editor(_masalah_controller),
                        15.height,
                        TextFieldWidget(
                          label: "Dampak",
                          text: _dampak,
                          maxLines: 5,
                          readonly: false,
                          onChanged: (value) {
                            setState(() {
                              _dampak = value;
                            });
                          },
                        ),
                        15.height,
                        TextFieldWidget(
                          label: "Penyebab",
                          text: _penyebab,
                          maxLines: 5,
                          readonly: false,
                          onChanged: (value) {
                            setState(() {
                              _penyebab = value;
                            });
                          },
                        ),
                        15.height,
                        TextFieldWidget(
                          label: "Solusi",
                          text: _solusi,
                          maxLines: 5,
                          readonly: false,
                          onChanged: (value) {
                            setState(() {
                              _solusi = value;
                            });
                          },
                        ),

                        TextFieldWidget(
                          label: "Syarat dan Hasil",
                          text: _hasil_perbaikan,
                          maxLines: 5,
                          readonly: false,
                          onChanged: (value) {
                            setState(() {
                              _hasil_perbaikan = value;
                            });
                          },
                        ),
                        15.height,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: penulisWidgets,
                        ),
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
                        10.height,
                        15.height,
                        UploadButtonWidget(
                          label: 'File Gambar *',
                          allowedExtensions: const ['jpg', 'png', 'jpeg'],
                          onChanged: (file) {
                            file_gambar_send[0] = file;
                          },
                        ),
                        15.height,
                        UploadButtonWidget(
                          label: 'File Dokumen *',
                          allowedExtensions: const ['pdf'],
                          onChanged: (file) {
                            file_docs_send[0] = file;
                          },
                        ),
                        15.height,
                        const text.Text(
                          "Lingkup Pengetahuan",
                          style: TextStyle(fontSize: 16, color: textColor),
                          textAlign: TextAlign.start,
                        ),
                        5.height,
                        DropdownButtonFormField<int>(
                          items: lingkupPengetahuanResult
                              .map<DropdownMenuItem<int>>(
                                  (LingkupPengetahuanResult lingkup) {
                            return DropdownMenuItem(
                              value: lingkup.id,
                              child: text.Text(
                                lingkup.nama,
                                style: const TextStyle(
                                    fontSize: 16, color: textColor),
                              ),
                            );
                          }).toList(),
                          onChanged: (int? value) {
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
                            //SUBMIT
                            //_ringkasan
                            // final ringkasan_converter =
                            //     QuillDeltaToHtmlConverter(
                            //   List.castFrom(_ringkasan_controller.document
                            //       .toDelta()
                            //       .toJson()),
                            //   ConverterOptions.forEmail(),
                            // );
                            // String ringkasan = ringkasan_converter.convert();
                            // //_masalah
                            // final masalah_converter = QuillDeltaToHtmlConverter(
                            //   List.castFrom(_masalah_controller.document
                            //       .toDelta()
                            //       .toJson()),
                            //   ConverterOptions.forEmail(),
                            // );
                            // String masalah = masalah_converter.convert();
                            // //_dampak
                            // final dampak_converter = QuillDeltaToHtmlConverter(
                            //   List.castFrom(_dampak_controller.document
                            //       .toDelta()
                            //       .toJson()),
                            //   ConverterOptions.forEmail(),
                            // );
                            // String dampak = dampak_converter.convert();
                            // //_penyebab
                            // final penyebab_converter =
                            //     QuillDeltaToHtmlConverter(
                            //   List.castFrom(_penyebab_controller.document
                            //       .toDelta()
                            //       .toJson()),
                            //   ConverterOptions.forEmail(),
                            // );
                            // String penyebab = penyebab_converter.convert();
                            // //_solusi
                            // final solusi_converter = QuillDeltaToHtmlConverter(
                            //   List.castFrom(_solusi_controller.document
                            //       .toDelta()
                            //       .toJson()),
                            //   ConverterOptions.forEmail(),
                            // );
                            // String solusi = solusi_converter.convert();
                            // //_syarat
                            // final syarat_converter = QuillDeltaToHtmlConverter(
                            //   List.castFrom(_syarat_controller.document
                            //       .toDelta()
                            //       .toJson()),
                            //   ConverterOptions.forEmail(),
                            // );
                            // String syarat = syarat_converter.convert();
                            handleSubmit();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shadowColor: Colors.transparent.withOpacity(0),
                            side: const BorderSide(
                              width: 1,
                              color: Colors.green,
                            ),
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

  int windex_penulias = 0;
  var penulisSelected = <String>[];
  Widget _penulis() {
    setState(() {
      windex_penulias++;
      penulisSelected.add("");
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 15.height,
        FastAutocomplete<String>(
          name: 'penulis',
          labelText: 'Penulis',
          options: penulis,
          initialValue:
              TextEditingValue(text: penulisSelected[windex_penulias - 1]),
          onChanged: (value) {
            setState(() {
              penulisSelected[windex_penulias - 1] = value!;
            });
          },
          onSelected: (option) {
            setState(() {
              penulisSelected[windex_penulias - 1] = option;
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

  int windex_document = -1;
  var documentSelected = <File>[];

  // _quill_toolbar(QuillController controller) {
  // return QuillToolbar.basic(
  //   controller: controller,
  //   showAlignmentButtons: true,
  //   showBackgroundColorButton: false,
  //   showCodeBlock: false,
  //   showClearFormat: false,
  //   showColorButton: false,
  //   showIndent: false,
  //   showInlineCode: false,
  //   showDividers: false,
  //   showListCheck: false,
  //   showQuote: false,
  //   showRedo: false,
  //   showUndo: false,
  //   showFontFamily: false,
  //   showFontSize: false,
  //   showDirection: false,
  //   showHeaderStyle: false,
  //   showSearchButton: false,
  //   showSubscript: false,
  //   showSuperscript: false,
  //   showStrikeThrough: false,
  //   axis: Axis.horizontal,
  //   toolbarIconAlignment: WrapAlignment.start,
  // );
  //}

  // _quill_editor(QuillController controller) {
  // return Container(
  //   height: 150,
  //   padding: const EdgeInsets.all(5.0),
  //   decoration: BoxDecoration(
  //     border: Border.all(
  //       width: 0.3,
  //       color: const Color.fromARGB(255, 35, 35, 35),
  //     ),
  //     borderRadius: BorderRadius.circular(9),
  //   ),
  //   child: QuillEditor.basic(
  //     controller: controller,
  //     readOnly: false, // true for view only mode
  //   ),
  // );
  //}

  // Widget docForm(int _windex_document) {
  //   return Column(
  //     children: [
  //       10.height,
  //       ElevatedButton(
  //         onPressed: () async {
  //           FilePickerResult? result = await FilePicker.platform.pickFiles(
  //             type: FileType.custom,
  //             allowedExtensions: ['jpg', 'png', 'pdf'],
  //           );

  //           if (result != null) {
  //             //File file = File(result.files.first);
  //             PlatformFile file = result.files.first;
  //             setState(() {
  //               documentSelected[_windex_document] =
  //                   File(result.files.single.path.toString());
  //               file_dokumen[_windex_document] = file.name;
  //             });
  //           } else {
  //             // User canceled the picker
  //           }
  //         },
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.grey,
  //           shadowColor: Colors.transparent.withOpacity(0),
  //           side: const BorderSide(
  //             width: 0,
  //             color: Colors.transparent,
  //           ),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //         ),
  //         child: Row(
  //           children: [
  //             const Icon(Icons.file_present_outlined,
  //                 color: Colors.white, size: 20),
  //             6.width,
  //             text.Text(
  //               file_dokumen[_windex_document],
  //               style: const TextStyle(color: Colors.white),
  //             ).expand(),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
