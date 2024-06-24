import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBarWidget(context,
            showLeadingIcon: false,
            title: 'Notifications',
            roundCornerShape: true,
            appBarHeight: 80),
        body: SizedBox());
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: false,
      elevation: 0.0,
      toolbarHeight: 50.0,
      backgroundColor: whiteColor,
      title: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Notifikasi",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).expand(),
              Container(
                margin: const EdgeInsets.only(top: 0),
                // child: IconBtnWithCounter(
                //   svgSrc: "assets/icons/bell.svg",
                //   numOfitem: "10", //notifCounter,
                //   press: () {
                //     Navigator.pushNamed(context, notificationRoute);
                //   },
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
