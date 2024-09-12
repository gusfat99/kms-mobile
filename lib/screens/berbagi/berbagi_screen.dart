// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_sub_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/page_berbagi_model.dart';
import 'package:kms_bpkp_mobile/routes.dart';
import 'package:kms_bpkp_mobile/screens/berbagi/add/kapitalis_screen.dart';
import 'package:kms_bpkp_mobile/screens/berbagi/add/kiat_screen.dart';
import 'package:kms_bpkp_mobile/screens/berbagi/add/resensi_screen.dart';
import 'package:kms_bpkp_mobile/screens/berbagi/add/tugas_screen.dart';
import 'package:kms_bpkp_mobile/screens/knowledge/api/knowledge_api.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:nb_utils/nb_utils.dart';

class BerbagiScreen extends StatefulWidget {
  const BerbagiScreen({super.key});

  @override
  State<BerbagiScreen> createState() => _BerbagiScreenState();
}

class _BerbagiScreenState extends State<BerbagiScreen> {
  int currentIndexPage = 0;
  int selectedService = -1;
  late List<JenisPengetahuanResult> pengetahuan = [];
  late List<SubJenisPengetahuanResult> subpengetahuan = [];
  late List<int> colors = [
    0xFF8D2913,
    0xFFAD3410,
    0xFFD14F0E,
    0xFFEC7114,
    0xFFF2932D,
    0xFFF4A743,
    0xFFFEBA54,
    0xFFFFCA77,
    0xFFFFCA77,
    0xFFFFCA77,
    0xFFFFCA77,
    0xFFFFCA77,
    0xFFFFCA77,
    0xFFFFCA77,
    0xFFFFCA77
  ];
  List<Widget> subJenisList = [];

  var _jenis_pengetahuan;
  var id_jenis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder<PageBerbagiModel>(
          future: KnowledgeService().getJenisPengetahuan(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              pengetahuan = snapshot.data!.jenisPengetahuanModel.results;
              subpengetahuan =
                  snapshot.data!.subJenisPengetahuanModel.results.toList();
              subpengetahuan.sort((a, b) => (b.id).compareTo(a.id));
              subJenisList.clear();

              for (int i = 0; i < subpengetahuan.length; i++) {
                subJenisList.add(
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(8),
                    decoration: boxDecoration(bgColor: mainColor, radius: 8),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: subpengetahuan[i].nama,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ).onTap(() {
                    finish(context);
                    switch (subpengetahuan[i].id.toString()) {
                      case "1": //Tugas (Panduan Penugasan)
                        TugasScreen(
                                title: _jenis_pengetahuan,
                                id_jenis: id_jenis,
                                sub_jenis_pengethuan: subpengetahuan[i].nama,
                                id_sub_jenis_pengetahuan: subpengetahuan[i].id)
                            .launch(context);

                        break;
                      case "2": //KIAT

                        KiatScreen(
                                title: _jenis_pengetahuan,
                                id_jenis: id_jenis,
                                sub_jenis_pengethuan: subpengetahuan[i].nama,
                                id_sub_jenis_pengetahuan: subpengetahuan[i].id)
                            .launch(context);

                        break;
                      case "3": //Kapitalisasi / Analytic Today
                        KapitalisKnowlegeScreen(
                                title: _jenis_pengetahuan,
                                id_jenis: id_jenis,
                                sub_jenis_pengethuan: subpengetahuan[i].nama,
                                id_sub_jenis_pengetahuan: subpengetahuan[i].id)
                            .launch(context);
                        break;
                      case "4": //Resensi
                        ResensiKnowlegeScreen(
                                title: _jenis_pengetahuan,
                                id_jenis: id_jenis,
                                sub_jenis_pengethuan: subpengetahuan[i].nama,
                                id_sub_jenis_pengetahuan: subpengetahuan[i].id)
                            .launch(context);

                        break;
                      case "5": //Aksi Perubahan
                        // PerubahanScreen(
                        //         title: _jenis_pengetahuan,
                        //         id_jenis: id_jenis,
                        //         sub_jenis_pengethuan: subpengetahuan[i].nama,
                        //         id_sub_jenis_pengetahuan: subpengetahuan[i].id)
                        //     .launch(context);
                        break;
                      case "6": //PKS (Pelatihan Kantor Sendiri)
                        // PksScreen(
                        //         title: _jenis_pengetahuan,
                        //         id_jenis: id_jenis,
                        //         sub_jenis_pengethuan: subpengetahuan[i].nama,
                        //         id_sub_jenis_pengetahuan: subpengetahuan[i].id)
                        //     .launch(context);
                        break;
                      case "7": //Karya Tulis
                        // KaryaTulisScreen(
                        //         title: _jenis_pengetahuan,
                        //         id_jenis: id_jenis,
                        //         sub_jenis_pengethuan: subpengetahuan[i].nama,
                        //         id_sub_jenis_pengetahuan: subpengetahuan[i].id)
                        //     .launch(context);
                        break;
                      case "8": //Newsletter LC
                        // NewsLaterScreen(
                        //         title: _jenis_pengetahuan,
                        //         id_jenis: id_jenis,
                        //         sub_jenis_pengethuan: subpengetahuan[i].nama,
                        //         id_sub_jenis_pengetahuan: subpengetahuan[i].id)
                        //     .launch(context);
                        break;
                      case "9": //Lainnya
                        // LainnyaScreen(
                        //         title: _jenis_pengetahuan,
                        //         id_jenis: id_jenis,
                        //         sub_jenis_pengethuan: subpengetahuan[i].nama,
                        //         id_sub_jenis_pengetahuan: subpengetahuan[i].id)
                        //     .launch(context);
                        break;
                    }
                  }),
                );
              }
            } else {
              if (snapshot.error == "Token Expired") {
                logout(context);
              }
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.height,
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                    ),
                    itemCount: pengetahuan.length,
                    itemBuilder: (_, index) {
                      return CardButton(
                              pengetahuan: pengetahuan[index],
                              color: colors[index])
                          .onTap(() {
                        setState(() {
                          _jenis_pengetahuan = pengetahuan[index].nama;
                          id_jenis = pengetahuan[index].id;
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog(
                              pengetahuan[index].nama, subJenisList),
                        );
                      });
                    },
                  ),
                  50.height
                ],
              ),
            );
          }),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      toolbarHeight: 160.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
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
                alignment: Alignment.center,
                child: Text(
                  "Berbagi Pengetahuan",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).expand(),
            ],
          ),
          50.height,
        ],
      ),
    );
  }
}

Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('login', false);
  prefs.clear();
  finish(context);
  Navigator.of(context)
      .pushNamedAndRemoveUntil(signinRoute, (Route<dynamic> route) => false);
}

class CardButton extends StatelessWidget {
  final JenisPengetahuanResult pengetahuan;
  final int color;
  const CardButton({Key? key, required this.pengetahuan, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = context.width();
    return Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        width: w,
        height: 50,
        decoration: BoxDecoration(
            color: Color(color),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: defaultBoxShadow(
                shadowColor: grayColorL2,
                blurRadius: 13,
                offset: const Offset(0.0, 5.0))),
        child: Center(
            child: Text(
          pengetahuan.nama,
          textAlign: TextAlign.center,
          style: const TextStyle(color: whiteColor),
        )));
  }
}

class CustomDialog extends StatelessWidget {
  List<Widget> subJenisList;

  String jenis_pengetahuan;

  CustomDialog(this.jenis_pengetahuan, this.subJenisList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: radius(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: context.cardColor,
          shape: BoxShape.rectangle,
          borderRadius: radius(8),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0)),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: Image(
                  width: MediaQuery.of(context).size.width,
                  image: const AssetImage('assets/images/widget_dialog.jpg'),
                  height: 120,
                  fit: BoxFit.cover),
            ),
            24.height,
            Text(jenis_pengetahuan, style: boldTextStyle(size: 18)),
            10.height,
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text("Pilih Sub Jenis Pengetahuan :",
                  style: secondaryTextStyle()),
            ),
            //16.height,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: subJenisList),
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
