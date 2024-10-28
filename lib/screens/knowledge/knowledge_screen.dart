import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_jenis_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/page_knowledge_model.dart';
import 'package:kms_bpkp_mobile/screens/error/error_screen.dart';
import 'package:kms_bpkp_mobile/screens/knowledge/api/knowledge_api.dart';
import 'package:kms_bpkp_mobile/screens/knowledge/components/knowledge_card_item_vertical.dart';
import 'package:kms_bpkp_mobile/screens/knowledge/knowledge_center_screen.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:nb_utils/nb_utils.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  final searchController = TextEditingController();

  late List<PengetahuanResult> pengetahuan = [];
  late List<JenisPengetahuanResult> jenisPengetahuan = [];
  var categories = [];
  var categoriesIds = [];
  int selectIndex = 0;

  String selectedId = "999"; // Semua

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PageKnowledgeModel>(
        future: KnowledgeService().getKnowledgeData(selectedId),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            pengetahuan = snapshot.data!.pengetahuanModel.pengetahuanResults;
            jenisPengetahuan = snapshot.data!.jenisPengetahuanModel.results;
            categories.clear();
            categoriesIds.clear();
            categories.add("Semua");
            categoriesIds.add("999");
            for (var element in jenisPengetahuan) {
              categories.add(element.nama);
              categoriesIds.add(element.id);
            }
            //User user = snapshot.data!.user;
            return Scaffold(
                appBar: buildAppBar(),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(categories.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                selectIndex = index;
                                setState(() {
                                  pengetahuan.clear();
                                  jenisPengetahuan.clear();
                                  selectedId = categoriesIds[index].toString();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  gradient: selectIndex == index
                                      ? defaultThemeGradient()
                                      : const LinearGradient(
                                          colors: [whiteColor, whiteColor]),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  border:
                                      Border.all(color: textColor, width: 0.5),
                                ),
                                child: Text(
                                  categories[index],
                                  style: primaryTextStyle(
                                      size: 14,
                                      color: selectIndex == index
                                          ? white
                                          : textColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      20.height,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: pengetahuan.length,
                        itemBuilder: (_, index) {
                          return KnowledgeCardItemVertical(
                                  pengetahuan[index], index)
                              .onTap(() {
                            KnowledgeCenterScreen(data: pengetahuan[index])
                                .launch(context);
                          });
                        },
                      ),
                      50.height
                    ],
                  ),
                ));
          } else if (snapshot.hasError) {
            return ErrorScreen(snapshot.toString());
          }
          return loadingIndicator(context);
        });
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      toolbarHeight: 140.0,
      backgroundColor: whiteColor,
      title: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Knowledge Center",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).expand(),
              // Container(
              //   margin: const EdgeInsets.only(top: 0),
              //   child: IconBtnWithCounter(
              //     svgSrc: "assets/icons/bell.svg",
              //     numOfitem: "10", //notifCounter,
              //     press: () {
              //       Navigator.pushNamed(context, notificationRoute);
              //     },
              //   ),
              // ),
            ],
          ),
          10.height,
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: const BorderRadius.all(Radius.circular(26)),
                  boxShadow: defaultBoxShadow(
                      shadowColor: grayColorL2,
                      blurRadius: 13,
                      offset: const Offset(0.0, 5.0))),
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          hintText: "Cari pengetahuan anda",
                          contentPadding: const EdgeInsets.only(
                              left: 26.0, bottom: 8.0, right: 50.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: white, width: 0.5),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: white, width: 0.5),
                            borderRadius: BorderRadius.circular(26),
                          ))),
                  GestureDetector(
                    onTap: () {
                      // PencarianScreen(keySearch: searchController.text)
                      //     .launch(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.search, color: grayColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
