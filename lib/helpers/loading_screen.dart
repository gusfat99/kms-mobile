import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: use_key_in_widget_constructors
class LoadingScreen extends StatefulWidget {
  static String tag = '/LoadingScreen';

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: appBar(context, 'Loading'),
        body: Container(
      //constraints: dynamicBoxConstraints(),
      //height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          const SpinKitFadingCircle(
            size: 40,
            color: mainColor,
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                // children: [
                //   Text("title", style: boldTextStyle(size: 24)),
                //   4.height,
                //   Text("desc",
                //           style: secondaryTextStyle(size: 14),
                //           textAlign: TextAlign.center)
                //       .paddingOnly(left: 20, right: 20),
                // ],
              ),
            ),
          )
        ],
      ),
    ).center());
  }
}
