import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/dots_indicator/dots_indicator.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';
import 'package:kms_bpkp_mobile/models/page_home_model.dart';
import 'package:kms_bpkp_mobile/routes.dart';
import 'package:kms_bpkp_mobile/screens/cop/components/cop_card_item_horizontal.dart';
import 'package:kms_bpkp_mobile/screens/cop/cop_detail_screen.dart';
import 'package:kms_bpkp_mobile/screens/home/api/home_api.dart';
import 'package:kms_bpkp_mobile/screens/knowledge/components/knowledge_card_item_horizontal.dart';
import 'package:kms_bpkp_mobile/screens/knowledge/knowledge_center_screen.dart';
import 'package:kms_bpkp_mobile/screens/pencarian/pencarian_screen.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/api_slider_model.dart';
import '../error/error_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.goToKnowledge, required this.goToCOP});
  final VoidCallback goToKnowledge;
  final VoidCallback goToCOP;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  int currentIndexPage = 0;
  late List<CopResult> cops = [];
  late List<PengetahuanResult> pengetahuan = [];
  late List<SliderModel> sliderData;
  late List<Widget> sliders = [];

  int dotCount = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PageHomeModel>(
        future: HomeService().getHomeData(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            pengetahuan = snapshot.data!.pengetahuanModel.pengetahuanResults;
            sliderData = snapshot.data!.sliderModel;
            sliders.clear();
            for (int i = 0; i < sliderData.length; i++) {
              SliderModel sl = sliderData[i];
              if (sl.thumbnail.url != "") {
                sliders.add(Slider(
                  file: sl.thumbnail.url,
                ));
              }
            }
            dotCount = sliders.length;
            cops = snapshot.data!.copModel.copResults;
            User user = snapshot.data!.user;
            int notifCounter = snapshot.data!.notificationCounter;

            return Scaffold(
                appBar: buildAppBar(user, notifCounter),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            child: PageView(
                              children: sliders,
                              //<Widget>[
                              // Slider(
                              //     file:
                              //         "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Jakarta_Skyline_Part_2.jpg/1200px-Jakarta_Skyline_Part_2.jpg"),
                              // Slider(
                              //     file:
                              //         "https://upload.wikimedia.org/wikipedia/commons/b/b6/Museum_fatahillah.jpg"),
                              // Slider(
                              //     file:
                              //         "https://upload.wikimedia.org/wikipedia/commons/d/da/Gelora_Bung_Karno_Stadium%2C_Asia_Cup_2007.jpg"),
                              //],
                              onPageChanged: (int i) {
                                setState(() {
                                  currentIndexPage = i;
                                });
                              },
                            ),
                          ),
                          Center(
                            child: Container(
                              transform:
                                  Matrix4.translationValues(0.0, 190.0, 0.0),
                              child: DotsIndicator(
                                  dotsCount: dotCount,
                                  position: currentIndexPage,
                                  decorator: const DotsDecorator(
                                    size: Size.square(10.0),
                                    activeSize: Size.square(13.0),
                                    color: grayColor,
                                    activeColor: whiteColor,
                                  )),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            transform:
                                Matrix4.translationValues(0.0, 205.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(26)),
                                    boxShadow: defaultBoxShadow(
                                        shadowColor: grayColor,
                                        blurRadius: 20)),
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: <Widget>[
                                    TextField(
                                        controller: searchController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: white,
                                            hintText: "Cari pengetahuan anda",
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 26.0,
                                                    bottom: 8.0,
                                                    right: 50.0),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: white, width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(26),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: white, width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(26),
                                            ))),
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder:
                                        //         (BuildContext context) {
                                        //   return PencarianScreen(keySearch: searchController.text);
                                        // }));
                                        // PencarianScreen(
                                        //         keySearch:
                                        //             searchController.text)
                                        //     .launch(context);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 16.0),
                                        child: Icon(Icons.search,
                                            color: grayColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      20.height,
                      Padding(
                          padding: const EdgeInsets.only(left: 0, right: 5.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Knowledge Center",
                                      style: boldTextStyle(size: 18)),
                                  Text(
                                    "Semua",
                                    style: primaryTextStyle(color: mainColor),
                                  ).onTap(
                                    () {
                                      widget.goToKnowledge.call();

                                      setState(() {});
                                    },
                                  ),
                                ],
                              ).paddingAll(16),
                              HorizontalList(
                                itemCount: pengetahuan.length,
                                itemBuilder: (_, index) {
                                  return KnowledgeCardItemHorizontal(
                                          pengetahuan[index], index)
                                      .onTap(() {
                                    KnowledgeCenterScreen(
                                      data: pengetahuan[index],
                                    ).launch(context);
                                  });
                                },
                              ),
                            ],
                          )),
                      10.height,
                      Padding(
                          padding: const EdgeInsets.only(left: 0, right: 5.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Forum COP",
                                      style: boldTextStyle(size: 18)),
                                  Text(
                                    "Semua",
                                    style: primaryTextStyle(color: mainColor),
                                  ).onTap(
                                    () {
                                      widget.goToCOP.call();
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ).paddingAll(16),
                              HorizontalList(
                                itemCount: cops.length,
                                itemBuilder: (_, index) {
                                  return CopCardItemHorizontal(
                                          cops[index], index)
                                      .onTap(() {
                                    CopDetailScreen(
                                      data: cops[index],
                                    ).launch(context);
                                  });
                                },
                              ),
                            ],
                          )),
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

  AppBar buildAppBar(User user, int notifCounter) {
    String placeholder = "assets/images/avatar_male.png";
    return AppBar(
      centerTitle: false,
      elevation: 1.0,
      toolbarHeight: 70.0,
      backgroundColor: whiteColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      user.foto != ""
                          ? CachedNetworkImage(
                              imageUrl: user.foto.url,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                margin: const EdgeInsets.only(top: 15),
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: mainColor, width: 0.5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageProvider,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                margin: const EdgeInsets.only(top: 15),
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: mainColor, width: 0.5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(placeholder),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                margin: const EdgeInsets.only(top: 15),
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: mainColor, width: 0.5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(placeholder),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(placeholder),
                                ),
                              ),
                            ),
                      5.height,
                    ],
                  ),
                ),
              ],
            ),
          ),
          10.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: "Hey, ${user.namaLengkap}!",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                    text: user.jabatan,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: grayColor,
                      fontWeight: FontWeight.normal,
                    )),
              )
            ],
          )
        ],
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: IconBtnWithCounter(
            svgSrc: "assets/icons/bell.svg",
            numOfitem: notifCounter.toString(),
            press: () {
              Navigator.pushNamed(context, notificationRoute);
            },
          ),
        ),
        SizedBox(
          width: SizeConfiguration.defaultSize * 0.5,
        )
      ],
    );
  }
}

class Slider extends StatelessWidget {
  final String file;
  const Slider({super.key, required this.file});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: CachedNetworkImage(
        placeholder:
            placeholderWidgetFn() as Widget Function(BuildContext, String)?,
        imageUrl: file,
        fit: BoxFit.fill,
      ),
    );
  }
}
