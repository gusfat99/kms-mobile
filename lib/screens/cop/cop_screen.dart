import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_cop_kategori.dart';
import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';
import 'package:kms_bpkp_mobile/models/page_cop_model.dart';
import 'package:kms_bpkp_mobile/screens/cop/api/cop_api.dart';
import 'package:kms_bpkp_mobile/screens/cop/components/cop_card_item_vertical.dart';
import 'package:kms_bpkp_mobile/screens/cop/cop_detail_screen.dart';
import 'package:kms_bpkp_mobile/screens/error/error_screen.dart';
import 'package:kms_bpkp_mobile/screens/pencarian/pencarian_cop_screen.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:nb_utils/nb_utils.dart';

import 'cop_add.dart';

class CopScreen extends StatefulWidget {
  const CopScreen({super.key});

  @override
  State<CopScreen> createState() => _CopScreenState();
}

class _CopScreenState extends State<CopScreen> {
  final searchController = TextEditingController();

  late List<CopResult> cops = [];

  late List<CopKategoriResult> copKategori = [];
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
    return FutureBuilder<PageCopModel>(
        future: CopService().getCopData(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            cops = snapshot.data!.copModel.copResults;

            copKategori = snapshot.data!.copKategoriModel.results;
            categories.clear();
            categoriesIds.clear();
            categories.add("Semua");
            categoriesIds.add("999");
            for (var element in copKategori) {
              categories.add(element.nama);
              categoriesIds.add(element.id);
            }
            User user = snapshot.data!.user;
            return Scaffold(
                appBar: buildAppBar(),
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    const CopAddScreen().launch(context);
                  },
                ),
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
                                  copKategori.clear();
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
                        itemCount: cops.length,
                        itemBuilder: (_, index) {
                          return CopCardItemVertical(cops[index], index)
                              .onTap(() {
                            CopDetailScreen(
                              data: cops[index],
                            ).launch(context);
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
                  "Forum COP",
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
            padding: const EdgeInsets.all(5),
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
                      // PencarianCOPScreen(keySearch: searchController.text)
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
