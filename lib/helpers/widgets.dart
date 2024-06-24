import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kms_bpkp_mobile/constant.dart';
import 'package:kms_bpkp_mobile/routes.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:nb_utils/nb_utils.dart';

import '../colors.dart';

AppBar buildAppBar({required title, required actions}) {
  return AppBar(
      backgroundColor: mainColor,
      leading: const BackButton(color: whiteClr),
      centerTitle: true,
      title: Text(title),
      actions: actions);
}

Widget loadingIndicator(context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: const Center(
      child: SpinKitFadingCircle(
        size: 40,
        color: mainColor,
      ),
    ),
  );
}

errorMessageModal({required String errorTitle, required String errorMessage}) {
  return Get.snackbar(
    errorTitle,
    errorMessage,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    icon: const Icon(Icons.close, color: Colors.white),
    titleText: const Text("Failed",
        style: TextStyle(
          fontFamily: "Muli",
          color: Colors.white,
          fontWeight: FontWeight.w600,
        )),
    messageText: Text(errorMessage,
        style: const TextStyle(fontFamily: "Muli", color: Colors.white)),
  );
}

Widget appBarTitleWidget(context, String title,
    {Color? color, Color? textColor}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    //color: color ?? appStore.appBarColor,
    child: Row(
      children: <Widget>[
        Text(
          title,
          style: boldTextStyle(color: color, size: 20),
          maxLines: 1,
        ).expand(),
      ],
    ),
  );
}

AppBar appBar(BuildContext context, String title,
    {final bool isDashboard = false,
    List<Widget>? actions,
    bool showBack = true,
    Color? color,
    Color? iconColor,
    Color? textColor,
    double? elevation}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: showBack
        ? IconButton(
            onPressed: () {
              if (isDashboard) {
                Navigator().launch(context,
                    isNewTask: true,
                    pageRouteAnimation: PageRouteAnimation.Fade);
              } else {
                finish(context);
              }
            },
            icon: Icon(Icons.arrow_back, color: black),
          )
        : null,
    title:
        appBarTitleWidget(context, title, textColor: textColor, color: color),
    actions: actions,
    elevation: elevation ?? 0.5,
  );
}

Widget errorWidget(
    BuildContext context, String image, String title, String desc,
    {bool showRetry = false, Function? onRetry}) {
  return Container(
    //constraints: dynamicBoxConstraints(),
    //height: MediaQuery.of(context).size.height,
    child: Stack(
      children: [
        Image.asset(
          image,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: Container(
            //decoration: boxDecorationRoundedWithShadow(8, backgroundColor: appStore.isDarkModeOn ? Colors.black26 : Colors.white70),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: boldTextStyle(size: 24)),
                4.height,
                Text(desc,
                        style: secondaryTextStyle(size: 14),
                        textAlign: TextAlign.center)
                    .paddingOnly(left: 20, right: 20),
                Column(
                  children: [
                    30.height,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: white,
                      ),
                      onPressed: () {
                        onRetry!();
                      },
                      child: Text('RETRY',
                          style: primaryTextStyle(color: textPrimaryColor)),
                    )
                  ],
                ).visible(showRetry),
              ],
            ),
          ),
        )
      ],
    ),
  ).center();
}

Widget searchScreen(
    {required String title,
    required String val,
    required Function(String) press,
    required Function() clearNow}) {
  var controller = TextEditingController(text: val);
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    child: TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: press,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: accentColor,
        ),
        hintText: title,
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: accentColor, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: accentColor, width: 1),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear,
              color: Color.fromARGB(255, 127, 125, 125)),
          onPressed: () {
            controller.clear();
            clearNow();
          },
        ),
      ),
    ),
  );
}

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    required this.svgSrc,
    this.numOfitem = "0",
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final String numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(0)),
            height: getProportionateScreenWidth(40),
            width: getProportionateScreenWidth(40),
            child: SvgPicture.asset(svgSrc),
          ),
          if (numOfitem != "0")
            Positioned(
              top: 3,
              right: 3,
              child: Container(
                height: getProportionateScreenWidth(15),
                width: getProportionateScreenWidth(15),
                decoration: const BoxDecoration(
                  color: redClr,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    numOfitem,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(8),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

Widget emptyScreen(
    {required String title, required String subTitle, required String image}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: EmptyWidget(
      image: image,
      //packageImage: PackageImage.Image_4,
      title: title,
      hideBackgroundAnimation: true,
      subTitle: subTitle,
      titleTextStyle: TextStyle(
        fontSize: getProportionateScreenWidth(22),
        color: const Color(0xff9da9c7),
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: getProportionateScreenWidth(14),
        color: const Color(0xffabb8d6),
      ),
    ),
  );
}

Widget errorScreen(BuildContext context, String? error,
    {required double size, required VoidCallback press}) {
  var msg = error ?? "";
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        EmptyWidget(
          image: "assets/images/error_icon.png",
          //packageImage: PackageImage.Image_4,
          title: "Error",
          hideBackgroundAnimation: true,
          subTitle: "Error found when execute request!",
          titleTextStyle: TextStyle(
            fontSize: getProportionateScreenWidth(22),
            color: const Color(0xff9da9c7),
            fontWeight: FontWeight.w500,
          ),
          subtitleTextStyle: TextStyle(
            fontSize: getProportionateScreenWidth(14),
            color: const Color(0xffabb8d6),
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 132, 51),
              minimumSize: const Size.fromHeight(40), // NEW
            ),
            onPressed: press,
            child: Text(
              "Retry",
              style: TextStyle(fontSize: getProportionateScreenWidth(13)),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: mainColor,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, errorRoute, arguments: msg);
            },
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "Message detail",
                  style: TextStyle(fontSize: getProportionateScreenWidth(13)),
                )),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget? Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() =>
    Image.asset('assets/images/placeholder.png', fit: BoxFit.cover);

Widget text(
  String? text, {
  var fontSize = textSizeLargeMedium,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
  TextStyle? style,
  TextAlign? textAlign,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: textColor ?? mainColor,
      height: 1.5,
      letterSpacing: latterSpacing,
      overflow: TextOverflow.ellipsis,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

Gradient defaultThemeGradient() {
  return LinearGradient(
    colors: [
      mainColor,
      mainColor.withOpacity(0.9),
    ],
    tileMode: TileMode.clamp,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}

PreferredSizeWidget commonAppBarWidget(BuildContext context,
    {String? title,
    double? appBarHeight,
    bool? showLeadingIcon,
    bool? bottomSheet,
    bool? roundCornerShape}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(appBarHeight ?? 100.0),
    child: AppBar(
      title: Text(title!, style: boldTextStyle(color: whiteColor, size: 20)),
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      backgroundColor: mainColor,
      centerTitle: true,
      leading: showLeadingIcon.validate()
          ? const SizedBox()
          : IconButton(
              onPressed: () {
                finish(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: whiteColor, size: 18),
              color: whiteColor,
            ),
      elevation: 0,
      shape: roundCornerShape.validate()
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)))
          : const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero),
            ),
    ),
  );
}
