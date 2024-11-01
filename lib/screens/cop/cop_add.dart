import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:form_validator/form_validator.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/loading_screen.dart';
import 'package:kms_bpkp_mobile/helpers/my_validation_locale.dart';
import 'package:kms_bpkp_mobile/helpers/text_field_widget.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_cop_kategori.dart';
import 'package:kms_bpkp_mobile/models/api_hashtag_model.dart';
import 'package:kms_bpkp_mobile/models/api_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_post_attachment_model.dart';
import 'package:kms_bpkp_mobile/models/page_input_cop_model.dart';
import 'package:kms_bpkp_mobile/screens/berbagi/api/input_pengetahuan_api.dart';
import 'package:kms_bpkp_mobile/screens/cop/api/cop_api.dart';
import 'package:kms_bpkp_mobile/screens/error/error_screen.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:kms_bpkp_mobile/utils.dart';
import 'package:nb_utils/nb_utils.dart';

class CopAddScreen extends StatefulWidget {
  const CopAddScreen({
    super.key,
  });
  @override
  State<CopAddScreen> createState() => _CopAddScreenState();
}

class _CopAddScreenState extends State<CopAddScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoadingSubmit = false;
  List<Widget> hashtagWidgets = <Widget>[];
  List<Widget> documentWidgets2 = <Widget>[];

  List<CopKategoriResult> copKategoriResult = [];
  List<JenisPengetahuanResult> jenisPengetahuanResult = [];
  List<String> copKategori = <String>[];
  List<HashTagResult> hashtagResult = [];
  List<String> hashtagOptions = <String>[];
  // DropdownMenuItem<JenisPengetahuanResult> jenisPengetahun = <JenisPengetahuanResult>[] as DropdownMenuItem<JenisPengetahuanResult>;

  List<File> document = <File>[];

  String fileGambar = "Pilih Gambar";
  List<String> fileDokumen = [];

  List<File> fileGambarSend = [];

  int fileGambarId = 0;
  List<int> fileDokumenId = [];

  // final QuillController _ringkasanController = QuillController.basic();

  var _judul = "";
  var _kategori = "";
  var _deskripsi = "";
  String? _selectedJenisPengetahuan;

  int windexReferensi = 0;
  var referensiSelected = <String>[];

  int windexHastag = 0;
  var hastagSelected = <String>[];

  Widget _hashtag() {
    setState(() {
      windexHastag++;
      hastagSelected.add("");
    });
    return Column(
      children: [
        15.height,
        FastAutocomplete<String>(
          name: 'hastag',
          labelText: 'Hastag',
          options: hashtagOptions,
          validator: ValidationBuilder(locale: locale).build(),
          initialValue:
              TextEditingValue(text: hastagSelected[windexHastag - 1]),
          onChanged: (value) {
            setState(() {
              hastagSelected[windexHastag - 1] = value!;
            });
          },
          onSelected: (option) {
            setState(() {
              hastagSelected[windexHastag - 1] = option;
            });
          },
        ),
      ],
    );
  }

  int windexDocument = -1;
  var documentSelected = <File>[];

  @override
  void initState() {
    setState(() {
      fileGambarSend.add(File(""));
      hashtagWidgets.add(_hashtag());
    });

    _addDoc();
    super.initState();
  }

  void _addDoc() {
    setState(() {
      windexDocument++;
      fileDokumen.add("Pilih Dokumen");
      documentSelected.add(File(""));
    });
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      //_formKey.currentState!.save();
      AppUtils.hideKeyboard(context);
      setState(() {
        isLoadingSubmit = true;
      });
      try {
        //HASHTAG
        var hashtagSend = [];
        List<String> hashtagSendApi = [];
        for (int i = 0; i < hashtagWidgets.length; i++) {
          var hasName = hastagSelected[i];
          var hasId = 0;
          for (var element in hashtagResult) {
            if (element.nama == hasName) {
              hasId = element.id;
              hashtagSend.add({"id": hasId});
            }
          }
          if (hasId == 0) {
            hashtagSendApi.add(hasName);
          }
        }

        //DOCUMENT
        List<File> documentSendApi = [];
        for (int i = 0; i <= documentWidgets2.length; i++) {
          File docFile = documentSelected[i];
          documentSendApi.add(docFile);
        }
        //SEND TAG
        List<int>? valueHastag =
            await InputPengetahuanService().submitNewHashTag(hashtagSendApi);

        List<dynamic> collectHastagId = [];

        for (int i = 0; i < valueHastag!.length; i++) {
          collectHastagId.add({"id": valueHastag[i]});
        }

        //NEXT
        if (fileGambarSend.isEmpty) {
          throw 'Silahkan  unggah gambar!';
        }
        //SEND IMAGE
        List<PostAttachModel>? valueGambar = await InputPengetahuanService()
            .submitNewKnowledgeAttachment(fileGambarSend);

        //SEND DOC
        List<PostAttachModel>? valueDokumen = await InputPengetahuanService()
            .submitNewKnowledgeAttachment(documentSendApi);

        List<int> docIdCollected = [];
        for (int x = 0; x < valueDokumen!.length; x++) {
          docIdCollected.add(valueDokumen[x].id);
        }

        setState(() {
          hashtagSend = collectHastagId;
          fileGambarId = valueGambar![0].id;
          fileDokumenId = docIdCollected;
          isLoadingSubmit = false;
        });
        //SUBMIT ALL
        //SEND FORM
        var docsSend = [];
        for (int ii = 0; ii < fileDokumenId.length; ii++) {
          docsSend.add({"id": fileDokumenId[ii]});
        }

        Map req = {
          "topik": "Topik",
          "kategori": _kategori.toLowerCase(),
          "judul": _judul,
          "deskripsi": _deskripsi,
          "tag": hashtagSend,
          "akademi_knowledge": {"id": _selectedJenisPengetahuan},
          "gambar": {"id": fileGambarId},
          "dokumen": docsSend[0],
        };
        CopService().submitNewCOP(req)?.then((valueSubmit) {
          toasty(context, "SUCCESS!");
          finish(context);
        }).catchError((e) {
          toasty(context, "7 : $e");
        });
      } catch (e) {
        toasty(context, "${e.toString()}");
        setState(() {
          isLoadingSubmit = false;
        });
      }
    } else {
      toasty(context, "1 : Silahkan periksa form anda!!");
    }
  }

  final locale = MyValidationLocale();

  @override
  Widget build(BuildContext context) {
    Widget document0() {
      return docForm(0);
    }

    Widget document1() {
      return docForm(1);
    }

    Widget document2() {
      return docForm(2);
    }

    Widget document3() {
      return docForm(3);
    }

    Widget document4() {
      return docForm(4);
    }

    Widget childdd() {
      List<Widget> widss = [];
      switch (windexDocument) {
        case 0:
          widss.add(document0());

          break;
        case 1:
          widss.add(document0());
          widss.add(document1());
          break;
        case 2:
          widss.add(document0());
          widss.add(document1());
          widss.add(document2());
          break;
        case 3:
          widss.add(document0());
          widss.add(document1());
          widss.add(document2());
          widss.add(document3());
          break;
        case 4:
          widss.add(document0());
          widss.add(document1());
          widss.add(document2());
          widss.add(document3());
          widss.add(document4());
          break;
      }
      //documentWidgets2 = widss;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widss,
      );
    }

    return FutureBuilder<PageInputCopModel>(
        future: CopService().getInputCopData(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            //SUB JENIS PENGETAHUAN
            copKategoriResult = snapshot.data!.copKategoriModel.results;
            jenisPengetahuanResult =
                snapshot.data!.jenisPengetahuanModel.results;

            copKategori.clear();
            copKategori.add("");
            for (var i = 0; i < copKategoriResult.length; i++) {
              copKategori.add(copKategoriResult[i].nama);
            }

            //HASHTAG
            hashtagOptions.clear();
            hashtagOptions.add("");
            hashtagResult = snapshot.data!.hashTagModel.results;
            for (var i = 0; i < hashtagResult.length; i++) {
              hashtagOptions.add(hashtagResult[i].nama);
            }

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
                        text("Kategori C.O.P",
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.start,
                            textColor: textColor),
                        5.height,
                        FastDropdown<String>(
                          name: 'dropdown',
                          items: copKategori,
                          validator: ValidationBuilder(locale: locale).build(),
                          initialValue: _kategori,
                          onChanged: (value) {
                            setState(() {
                              _kategori = value!;
                            });
                          },
                        ),
                        15.height,
                        text(
                          "Akademi Knowledge",
                          textColor: textColor,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                        15.height,
                        DropdownButtonFormField<String>(
                          value: _selectedJenisPengetahuan,
                          validator: ValidationBuilder(locale: locale).build(),
                          items: jenisPengetahuanResult
                              .map<DropdownMenuItem<String>>(
                                  (JenisPengetahuanResult value) {
                            return DropdownMenuItem<String>(
                              value: value.id.toString(),
                              child: text(
                                value.nama,
                                textColor: textColor,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                            );
                          }).toList(),
                          // initialValue: ,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedJenisPengetahuan = value!;
                            });
                            // _kategori = value!;
                          },
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
                              text("Tambah Hashtag", fontSize: 12.0),
                            ],
                          ),
                        ),
                        TextFieldWidget(
                          label: "Deskripsi",
                          text: _judul,
                          validator: ValidationBuilder(locale: locale).build(),
                          maxLines: 4,
                          readonly: false,
                          onChanged: (value) {
                            setState(() {
                              _deskripsi = value;
                            });
                          },
                        ),
                        15.height,
                        text(
                          "Upload Dokumen",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        15.height,
                        text(
                          "File Dokumen *",
                          fontSize: 16.0,
                          textAlign: TextAlign.start,
                        ),
                        10.height,
                        ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'png'],
                            );

                            if (result != null) {
                              //File file = File(result.files.first);
                              PlatformFile file = result.files.first;
                              setState(() {
                                fileGambarSend[0] =
                                    File(result.files.single.path.toString());
                                fileGambar = file.name;
                              });
                            } else {
                              // User canceled the picker
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
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
                              const Icon(Icons.image_outlined,
                                  color: Colors.white, size: 20),
                              6.width,
                              text(
                                fileGambar,
                                textColor: whiteColor,
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.start,
                              ).expand(),
                            ],
                          ),
                        ),
                        5.height,
                        text(
                          "* Max 1Mb, Format .jpg/.png",
                          fontSize: 12.0,
                          textAlign: TextAlign.start,
                        ),
                        15.height,
                        text(
                          "File Dokumen *",
                          fontSize: 16.0,
                          textAlign: TextAlign.start,
                        ),
                        childdd(),
                        5.height,
                        text(
                          "* Max 1Mb, Format .jpg/.png/.pdf",
                          fontSize: 12.0,
                          style: const TextStyle(fontSize: 12.0),
                          textAlign: TextAlign.start,
                        ),
                        15.height,
                        ElevatedButton(
                          onPressed: isLoadingSubmit
                              ? null
                              : () async {
                                  //SUBMIT

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
                            child: isLoadingSubmit
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.save,
                                          color: whiteColor, size: 20),
                                      6.width,
                                      text(
                                        "SIMPAN",
                                        textColor: whiteColor,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.start,
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
                child: text(
                  "Forum COP",
                  textColor: whiteColor,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
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

  // _quillToolbar(QuillController controller) {
  //   return QuillToolbar.basic(
  //     controller: controller,
  //     showAlignmentButtons: true,
  //     showBackgroundColorButton: false,
  //     showCodeBlock: false,
  //     showClearFormat: false,
  //     showColorButton: false,
  //     showIndent: false,
  //     showInlineCode: false,
  //     showListCheck: false,
  //     showQuote: false,
  //     showHeaderStyle: false,
  //     showStrikeThrough: false,
  //   );
  // }

  // _quillEditor(QuillController controller) {
  //   return Container(
  //     height: 150,
  //     padding: const EdgeInsets.all(5.0),
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         width: 0.3,
  //         color: const Color.fromARGB(255, 35, 35, 35),
  //       ),
  //       borderRadius: BorderRadius.circular(9),
  //     ),
  //     child: QuillEditor.basic(
  //       controller: controller,
  //       readOnly: false, // true for view only mode
  //     ),
  //   );
  // }

  Widget docForm(int windexDocument) {
    return Column(
      children: [
        10.height,
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['jpg', 'png', 'pdf'],
            );

            if (result != null) {
              //File file = File(result.files.first);
              PlatformFile file = result.files.first;
              setState(() {
                documentSelected[windexDocument] =
                    File(result.files.single.path.toString());
                fileDokumen[windexDocument] = file.name;
              });
            } else {
              // User canceled the picker
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
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
              const Icon(Icons.file_present_outlined,
                  color: Colors.white, size: 20),
              6.width,
              text(
                fileDokumen[windexDocument],
                textColor: whiteColor,
                textAlign: TextAlign.start,
              ).expand()
            ],
          ),
        ),
      ],
    );
  }
}
